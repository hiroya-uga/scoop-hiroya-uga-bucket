if (-not (Get-Command scoop -ErrorAction SilentlyContinue)) {
  iwr -useb get.scoop.sh | iex
}

$Buckets = @(
  @{ Name="main" },
  @{ Name="extras" },
  @{ Name="hiroya-uga"; Url="https://github.com/hiroya-uga/scoop-hiroya-uga-bucket" }
)

$buckets = scoop bucket list | Select-Object -Skip 2 |
    ConvertFrom-String -PropertyNames Name, Source -Delimiter '\s{2,}'

foreach ($bucket in $Buckets) {
  if (-not ($buckets.Name -contains $bucket.Name)) {
    scoop bucket rm $($bucket.Name)

    if ($bucket.ContainsKey('Url')) {
      scoop bucket add $($bucket.Name) $($bucket.Url)
    } else {
      scoop bucket add $($bucket.Name)
    }
  }
}

# for https://github.com/hiroya-uga/setup
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$json = Get-Content "$scriptDir\scoopfile.json" | ConvertFrom-Json

Write-Host "🍣 Installing packages from $scriptDir\scoopfile.json ..."

$packages = $json.apps
$installed = scoop list
$notInstalled = @($packages | Where-Object {
  -not ($installed | Select-String -SimpleMatch $_)
})

# 配列をスペース区切り文字列にして一括 install
if ($notInstalled.Count -gt 0) {
    $pkgString = $notInstalled -join " "
    Write-Host "   $pkgString"
    & scoop install $pkgString
} else {
    Write-Host "All packages are already installed"
}



Write-Host "✅ Scoop installation completed!"
Write-Host ""

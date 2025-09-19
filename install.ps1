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

# for Invoke-WebRequest (PowerShell)
scoop install git gpg4win gsudo mise nvda-jp openssh powertoys pwsh sublime-text vim vscode winmerge

Write-Host "✅ Scoop installation completed!"
Write-Host ""

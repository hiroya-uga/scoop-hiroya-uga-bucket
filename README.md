# scoop-hiroya-uga-bucket

Personal Scoop bucket for Windows.  
Used as a **submodule** in <https://github.com/hiroya-uga/setup>.

This will:

-   Install Scoop if needed
-   Add `main`, `extras`, and `hiroya-uga`(this) buckets
-   Import apps from scoopfile.json

## Simple install

```pwsh
iwr -useb https://raw.githubusercontent.com/hiroya-uga/scoop-hiroya-uga-bucket/main/install.ps1 | iex
```

@ECHO OFF

@powershell -NoProfile -Command "Import-Module %~dp0/ngrams; Get-Content -Raw %1 | Get-NGrams -N 2 | Format-Histogram"

$packageName= 'GnuCOBOL'
$distDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://arnoldtrembley.com/GC312-BDB-SP2-rename-7z-to-exe.7z'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $distDir
  fileType      = 'exe'
  url           = $url

  softwareName  = 'GnuCOBOL*'

  checksum      = '8949A1985B5E4E2C4DE622E56B86E05FE85DAA0906E8A690C478CC2542DE4BD7'
  checksumType  = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

$files = Get-ChildItem $($distDir) -Include *.exe -Exclude cobc.exe,cobcrun.exe -Recurse
foreach ($file in $files) {
  # We only want to shim cobc and cobcrun.
  New-Item "$file.ignore" -type file -force | Out-Null
}

Install-ChocolateyEnvironmentVariable -VariableName "COB_CONFIG_DIR" -VariableValue "$($distDir)\config"
Install-ChocolateyEnvironmentVariable -VariableName "COB_CFLAGS" -VariableValue "-I`"$($distDir)\include`""
Install-ChocolateyEnvironmentVariable -VariableName "COB_LIBRARY_PATH" -VariableValue "/LIBPATH:`"$($distDir)\lib`""
Install-ChocolateyEnvironmentVariable -VariableName "COB_LIBS" -VariableValue "/LIBPATH:`"$($distDir)\lib\libcob.lib`""

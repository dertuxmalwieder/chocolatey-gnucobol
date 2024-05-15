$packageName= 'GnuCOBOL'
$distDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://arnoldtrembley.com/GC32-BDB-rename-7z-to-exe.7z'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $distDir
  fileType      = 'exe'
  url           = $url

  softwareName  = 'GnuCOBOL*'

  checksum      = '095C6C0F5B4BFA6D2609AE90D26E184510CB5A24B7644A4FB62AB7A6F9E7B2DC'
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
Install-ChocolateyEnvironmentVariable -VariableName "COB_LIB_PATH" -VariableValue "-L:`"$($distDir)\lib`""
Install-ChocolateyEnvironmentVariable -VariableName "COB_LIBRARY_PATH" -VariableValue "/LIBPATH:`"$($distDir)\extras`""
Install-ChocolateyEnvironmentVariable -VariableName "COB_LIBS" -VariableValue "-lcob"

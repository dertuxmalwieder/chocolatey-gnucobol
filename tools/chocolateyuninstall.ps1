$ErrorActionPreference = 'Stop';

$uninstalled = $false

# Clean the environment from our installed variables:
Uninstall-ChocolateyEnvironmentVariable -VariableName "COB_CONFIG_DIR"
Uninstall-ChocolateyEnvironmentVariable -VariableName "COB_CFLAGS"
Uninstall-ChocolateyEnvironmentVariable -VariableName "COB_LIBRARY_PATH"
Uninstall-ChocolateyEnvironmentVariable -VariableName "COB_LIBS"
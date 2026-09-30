@echo off
set MODULE_NAME=%1

if "%MODULE_NAME%"=="" (
    echo Please provide a module name.
    echo Usage: create_module.bat ^<module_name^>
    exit /b 1
)

set BASE_DIR=lib\modules\%MODULE_NAME%

echo Creating module architecture for: %MODULE_NAME%

mkdir "%BASE_DIR%\api\api_client" 2>nul
mkdir "%BASE_DIR%\api\datasources" 2>nul

mkdir "%BASE_DIR%\data\datasources" 2>nul
mkdir "%BASE_DIR%\data\models" 2>nul
mkdir "%BASE_DIR%\data\models\requests" 2>nul
mkdir "%BASE_DIR%\data\models\response" 2>nul
mkdir "%BASE_DIR%\data\repositories" 2>nul

mkdir "%BASE_DIR%\domain\entities" 2>nul
mkdir "%BASE_DIR%\domain\repositories" 2>nul
mkdir "%BASE_DIR%\domain\use_cases" 2>nul

mkdir "%BASE_DIR%\presentation\cubit" 2>nul
mkdir "%BASE_DIR%\presentation\pages" 2>nul
mkdir "%BASE_DIR%\presentation\widgets" 2>nul

echo Module architecture created at %BASE_DIR%

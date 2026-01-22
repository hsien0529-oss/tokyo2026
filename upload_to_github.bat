@echo off
chcp 65001 > nul
cd /d "%~dp0"

echo ========================================
echo   東京旅遊網站 - GitHub 上傳工具
echo ========================================
echo.

:: 檢查是否有變更
git status --porcelain > nul 2>&1
if errorlevel 1 (
    echo [錯誤] 這不是一個 Git 儲存庫！
    pause
    exit /b 1
)

:: 顯示變更的檔案
echo [1/4] 檢查變更的檔案...
git status --short
echo.

:: 詢問是否繼續
set /p confirm="確定要上傳這些變更嗎? (Y/N): "
if /i not "%confirm%"=="Y" (
    echo 已取消上傳。
    pause
    exit /b 0
)

:: 詢問 commit 訊息
echo.
set /p message="請輸入更新說明 (直接按 Enter 使用預設): "
if "%message%"=="" set message=Update website content

:: 執行 git 指令
echo.
echo [2/4] 新增所有檔案...
git add .

echo [3/4] 建立提交: %message%
git commit -m "%message%"

echo [4/4] 推送到 GitHub...
git push

echo.
echo ========================================
echo   ✓ 上傳完成！
echo   網址: https://hsien0529-oss.github.io/tokyo2026/
echo ========================================
echo.
pause

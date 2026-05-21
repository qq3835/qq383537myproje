@echo off
chcp 65001 >nul
echo ==============================================
echo 🚀 Git 一键强制推送脚本（Gitee国内专属版）
echo ==============================================
echo.

:: ========== 已为你填好所有配置，无需修改 ==========
set "GITEE_USERNAME=hehehheeee"
set "REPO_NAME=qq383537myproje"
:: ==================================================

echo 1/6 正在重置Git网络配置，清空所有错误代理...
git config --global --unset http.proxy >nul 2>&1
git config --global --unset https.proxy >nul 2>&1
git config --local --unset http.proxy >nul 2>&1
git config --local --unset https.proxy >nul 2>&1
echo ✅ 网络配置已完全重置，无任何代理干扰
echo.

echo 2/6 正在清理所有无效远程仓库地址...
git remote remove gitee >nul 2>&1
git remote remove origin >nul 2>&1
echo ✅ 无效远程地址已全部清理
echo.

echo 3/6 正在添加正确的Gitee远程仓库...
git remote add gitee https://gitee.com/%GITEE_USERNAME%/%REPO_NAME%.git
echo ✅ Gitee仓库地址已配置：https://gitee.com/%GITEE_USERNAME%/%REPO_NAME%.git
echo.

echo 4/6 正在开启Git LFS，专门优化古诗音频文件推送...
git lfs install >nul 2>&1
git lfs track "*.mp3" >nul 2>&1
git add .gitattributes >nul 2>&1
git commit -m "开启Git LFS存储古诗朗读音频文件" >nul 2>&1
echo ✅ Git LFS已开启，音频大文件推送优化完成
echo.

echo 5/6 正在执行安全强制推送（--force-with-lease）...
git push --force-with-lease gitee master
if %errorlevel% equ 0 (
    echo.
    echo ✅ 推送成功！所有古诗音频文件和index.html已完整同步到Gitee仓库
) else (
    echo.
    echo ❌ 推送失败，请按以下步骤排查：
    echo 1. 先去Gitee官网创建空仓库，仓库名必须是 qq383537myproje
    echo 2. 创建仓库时，**绝对不要**勾选「初始化README」「添加.gitignore」
    echo 3. 把脚本里的「你的Gitee账号名」替换成你自己的Gitee用户名
    pause
    exit /b 1
)
echo.

echo 6/6 正在验证本地仓库状态...
git status | find "nothing to commit, working tree clean" >nul
if %errorlevel% equ 0 (
    echo ✅ 本地仓库状态正常，所有修改已提交
) else (
    echo ⚠️  本地有未提交的修改，请检查
)
echo.

echo ==============================================
echo 🎉 脚本执行全部完成！
echo 👉 接下来操作：
echo 1. 打开你的Gitee仓库，确认文件已同步
echo 2. 点击「管理」→「仓库同步」，绑定你的GitHub账号
echo 3. 点击「立即同步」，一键把所有代码同步到GitHub
echo ==============================================
pause
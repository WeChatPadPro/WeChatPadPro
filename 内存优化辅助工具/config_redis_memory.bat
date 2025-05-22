@echo off
:: Redis内存配置脚本 - Windows版本
:: 使用方法: config_redis_memory.bat [host] [port] [password] [maxmemory] [policy]
:: 默认值: host=localhost, port=6379, 无密码, maxmemory=1GB, policy=allkeys-lru

setlocal EnableDelayedExpansion

:: 设置默认值
set "REDIS_HOST=localhost"
set "REDIS_PORT=6379"
set "REDIS_PASS="
set "REDIS_MAXMEM=1GB"
set "REDIS_POLICY=allkeys-lru"

:: 检查是否有参数传入
if not "%1"=="" set "REDIS_HOST=%1"
if not "%2"=="" set "REDIS_PORT=%2"
if not "%3"=="" set "REDIS_PASS=%3"
if not "%4"=="" set "REDIS_MAXMEM=%4"
if not "%5"=="" set "REDIS_POLICY=%5"

echo ===== Redis内存配置工具 =====
echo Redis服务器: %REDIS_HOST%:%REDIS_PORT%
echo 最大内存: %REDIS_MAXMEM%
echo 内存策略: %REDIS_POLICY%

:: 构建Redis命令行
set "REDIS_CMD=redis-cli -h %REDIS_HOST% -p %REDIS_PORT%"
if not "%REDIS_PASS%"=="" (
    set "REDIS_CMD=!REDIS_CMD! -a %REDIS_PASS%"
    echo 使用密码认证
)

:: 测试连接
echo|set /p="测试Redis连接... "
%REDIS_CMD% PING > nul 2>&1
if not %ERRORLEVEL% == 0 (
    echo 失败！
    echo 无法连接到Redis服务器。请检查连接参数。
    goto :end
) else (
    echo 成功！
)

:: 设置最大内存
echo|set /p="配置最大内存限制... "
%REDIS_CMD% CONFIG SET maxmemory %REDIS_MAXMEM% > nul 2>&1
if not %ERRORLEVEL% == 0 (
    echo 失败！
    echo 无法设置maxmemory。可能需要管理员权限或Redis配置不允许CONFIG命令。
) else (
    echo 成功！
)

:: 设置内存策略
echo|set /p="配置内存淘汰策略... "
%REDIS_CMD% CONFIG SET maxmemory-policy %REDIS_POLICY% > nul 2>&1
if not %ERRORLEVEL% == 0 (
    echo 失败！
    echo 无法设置maxmemory-policy。可能需要管理员权限或Redis配置不允许CONFIG命令。
) else (
    echo 成功！
)

:: 持久化配置到redis.conf
echo|set /p="尝试持久化配置到Redis配置文件... "
%REDIS_CMD% CONFIG REWRITE > nul 2>&1
if not %ERRORLEVEL% == 0 (
    echo 失败！
    echo 无法持久化配置。Redis配置可能是只读的或CONFIG REWRITE不被支持。
    echo 请手动编辑redis.conf或redis.windows.conf文件，添加或修改以下配置行：
    echo   maxmemory %REDIS_MAXMEM%
    echo   maxmemory-policy %REDIS_POLICY%
) else (
    echo 成功！
)

:: 验证设置
echo|set /p="验证配置... "
for /f "tokens=2" %%i in ('%REDIS_CMD% CONFIG GET maxmemory ^| findstr /v maxmemory') do set "CURRENT_MAXMEM=%%i"
for /f "tokens=2" %%i in ('%REDIS_CMD% CONFIG GET maxmemory-policy ^| findstr /v maxmemory-policy') do set "CURRENT_POLICY=%%i"

echo.
echo 当前配置:
echo   maxmemory: %CURRENT_MAXMEM%
echo   maxmemory-policy: %CURRENT_POLICY%

echo ===== 配置完成 =====

:: 说明
echo.
echo 内存策略说明:
echo   noeviction: 当内存不足时返回错误，不删除任何键
echo   allkeys-lru: 删除最近最少使用的键
echo   volatile-lru: 仅删除设置了过期时间的键中最近最少使用的
echo   allkeys-random: 随机删除键
echo   volatile-random: 仅随机删除设置了过期时间的键
echo   volatile-ttl: 删除最接近过期的键
echo.
echo 建议配置对于防止内存泄漏:
echo   maxmemory: 设置为服务器内存的60-70%%
echo   maxmemory-policy: allkeys-lru 或 volatile-lru

:end
pause 
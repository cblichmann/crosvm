:: Copyright 2022 The Chromium OS Authors. All rights reserved.
:: Use of this source code is governed by a BSD-style license that can be
:: found in the LICENSE file.

:: Make environment changes (cd, env vars, etc.) local, so they don't affect the calling batch file
setlocal

:: Code under repo is checked out to %KOKORO_ARTIFACTS_DIR%\git.
:: The final directory name in this path is determined by the scm name specified
:: in the job configuration
cd %KOKORO_ARTIFACTS_DIR%\git\crosvm

:: Pin rustup to a known/tested version.
set rustup_version=1.24.3

:: Install rust toolchain through rustup.
echo [%TIME%] installing rustup %rustup_version%
choco install --no-progress -y rustup.install --version=%rustup_version% --ignore-checksums

:: Reload path for installed rustup binary
call RefreshEnv.cmd

:: Toolchain version and necessary components will be automatically picked
:: up from rust-toolchain
cargo install bindgen

:: Install python. The default kokoro intalled version is 3.7 but linux tests
:: seem to run on 3.9+.
choco install --no-progress -y python --version=3.9.0

:: Reload path for installed rust toolchain.
call RefreshEnv.cmd

:: Log the version of the Rust toolchain
echo [%TIME%] Using Rust toolchain version:
cargo --version
rustc --version

:: Log python version
echo [%TIME%] Python version:
py --version

py -m pip install argh --user

echo [%TIME%] Calling crosvm\tools\clippy
py .\tools\clippy
if %ERRORLEVEL% neq 0 ( exit /b %ERRORLEVEL% )

echo [%TIME%] Calling crosvm\tools\run_tests
py .\tools\run_tests --build-target=x86_64-pc-windows-msvc -v
if %ERRORLEVEL% neq 0 ( exit /b %ERRORLEVEL% )

exit /b %ERRORLEVEL%

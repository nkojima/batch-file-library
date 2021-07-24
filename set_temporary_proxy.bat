# PROXYを一時的に設定する。
# ※OS再起動で設定が失われる。

set HTTP_PROXY=http://username:password@proxy.test.com:proxy_port
set HTTPS_PROXY=http://username:password@proxy.test.com:proxy_port

# PROXYの認証が不要な場合はこちら。
set HTTP_PROXY=http://proxy.test.com:proxy_port
set HTTPS_PROXY=http://proxy.test.com:proxy_port

# 設定値の確認
echo %HTTP_PROXY%
echo %HTTPS_PROXY%
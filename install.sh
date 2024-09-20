
#!/bin/bash

# Kiểm tra xem API token đã được cung cấp chưa
if [ -z "$CLOUDFLARE_API_TOKEN" ]; then
  echo "Vui lòng cung cấp API token của Cloudflare bằng cách đặt biến môi trường CLOUDFLARE_API_TOKEN."
  echo "Ví dụ: export CLOUDFLARE_API_TOKEN=your_cloudflare_api_token"
  exit 1
fi

# Cập nhật hệ thống và cài đặt Node.js và npm
sudo apt update
sudo apt install -y nodejs npm

# Kiểm tra và gỡ cài đặt Cloudflare Wrangler nếu đã cài đặt
if npm list -g | grep -q wrangler; then
  npm uninstall -g wrangler
fi

# Cài đặt Cloudflare Wrangler
npm install -g wrangler

# Đăng nhập vào Cloudflare bằng API token
mkdir -p ~/.wrangler/config
echo "api_token = \"$CLOUDFLARE_API_TOKEN\"" > ~/.wrangler/config/default.toml

# Xóa thư mục temp-email-service nếu đã tồn tại
rm -rf temp-email-service

# Tải mã nguồn từ repository
git clone https://github.com/gohcx/temporary-email-service.git temp-email-service
cd temp-email-service

# Thêm domain tùy chỉnh vào tệp wrangler.toml
cat <<EOT > wrangler.toml
kv_namespaces = [{ binding = "kv4email", id = "xxxxxxxxxx" }]
main = "src/worker.js"
routes = [ { pattern = "chiase.sale", custom_domain = true }]
EOT

# Triển khai mã nguồn lên Cloudflare Workers
wrangler deploy

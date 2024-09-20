
#!/bin/bash

# Cập nhật hệ thống và cài đặt Node.js và npm
sudo apt update
sudo apt install -y nodejs npm

# Cài đặt Cloudflare Wrangler
npm install -g wrangler

# Đăng nhập vào Cloudflare
wrangler login

# Sao chép mã nguồn từ repository
git clone https://github.com/gohcx/temporary-email-service.git temp-email-service
cd temp-email-service

# Triển khai mã nguồn lên Cloudflare Workers
wrangler deploy

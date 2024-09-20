
#!/bin/bash

# Cập nhật hệ thống và cài đặt Node.js và npm
sudo apt update
sudo apt install -y nodejs npm

# Cài đặt Cloudflare Wrangler
npm install -g wrangler

# Đăng nhập vào Cloudflare
wrangler login

# Triển khai mã nguồn lên Cloudflare Workers
cd $(dirname "$0")
wrangler deploy

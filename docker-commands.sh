#!/bin/bash
# =============================================================================
# 🐳 Docker Commands Cheat Sheet
# =============================================================================
# คำอธิบาย: สรุปคำสั่ง Docker ทั้งหมดที่ใช้บ่อย พร้อมคำอธิบายภาษาไทย
# Author: Docker Commands Summary
# =============================================================================

# =============================================================================
# 🔧 1. ตรวจสอบและตั้งค่าระบบ (System Info & Setup)
# =============================================================================

# ตรวจสอบเวอร์ชัน Docker
docker --version

# ดูข้อมูลระบบ Docker
docker info

# ตรวจสอบเวอร์ชัน Docker Compose
docker compose version

# เข้าสู่ระบบ Docker Hub
docker login

# ออกจากระบบ Docker Hub
docker logout

# =============================================================================
# 📦 2. การจัดการ Images
# =============================================================================

# ดูรายการ image ทั้งหมด
docker images
docker image ls

# ดาวน์โหลด image จาก Docker Hub
docker pull nginx
docker pull node:20-alpine
docker pull mongo:7

# ลบ image
docker rmi <image_id>
docker rmi -f <image_id>  # บังคับลบ

# เปลี่ยนชื่อหรือแท็ก image
docker tag <source_image> <target_image>
docker tag myapp:latest username/myapp:1.0.0

# สร้าง image จาก Dockerfile
docker build -t myapp .
docker build -t myapp:1.0.0 .
docker build -t myapp:latest -f Dockerfile.dev .  # ใช้ Dockerfile อื่น
docker build --target production -t myapp:prod .  # ใช้ target stage

# ลบ image ที่ไม่ได้ใช้งาน
docker image prune
docker image prune -a  # ลบทั้งหมดที่ไม่ได้ใช้

# ดูรายละเอียด image
docker image inspect <image_id>

# ดูประวัติ layer ของ image
docker image history <image_id>

# =============================================================================
# 🧱 3. การจัดการ Containers
# =============================================================================

# ดู container ที่กำลังทำงาน
docker ps

# ดู container ทั้งหมด (รวมที่หยุดแล้ว)
docker ps -a

# สร้างและรัน container ใหม่
docker run nginx
docker run -d nginx                           # รันแบบ background
docker run -d -p 8080:80 nginx               # map port
docker run -d -p 8080:80 --name web nginx    # กำหนดชื่อ
docker run -d -p 8080:80 --name web -v ./html:/usr/share/nginx/html nginx  # mount volume

# รัน container แบบมี environment variables
docker run -d -e NODE_ENV=production -e PORT=3000 myapp

# รัน container แบบ interactive
docker run -it node:alpine /bin/sh
docker run -it --rm node:alpine node         # ลบอัตโนมัติหลังจากหยุด

# เริ่ม container ที่หยุดไว้
docker start <container_id>
docker start <container_name>

# หยุด container
docker stop <container_id>
docker stop <container_name>

# รีสตาร์ท container
docker restart <container_id>

# บังคับหยุด container
docker kill <container_id>

# ลบ container
docker rm <container_id>
docker rm -f <container_id>  # บังคับลบ (รวมที่กำลังรัน)

# ลบ container ที่หยุดทำงานทั้งหมด
docker container prune

# =============================================================================
# 🔍 4. ตรวจสอบและ Debug Containers
# =============================================================================

# ดู log ของ container
docker logs <container_id>
docker logs -f <container_id>           # realtime (follow)
docker logs --tail 100 <container_id>   # 100 บรรทัดล่าสุด
docker logs --since 1h <container_id>   # log ใน 1 ชั่วโมงที่ผ่านมา

# เข้า shell ภายใน container
docker exec -it <container_id> bash
docker exec -it <container_id> sh
docker exec -it <container_id> /bin/bash

# รันคำสั่งใน container
docker exec <container_id> ls -la
docker exec <container_id> cat /etc/hosts

# ดูรายละเอียดเต็มของ container
docker inspect <container_id>

# ดูเฉพาะ IP Address
docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' <container_id>

# ดู process ที่รันอยู่ใน container
docker top <container_id>

# ดู resource usage (CPU, Memory)
docker stats
docker stats <container_id>

# คัดลอกไฟล์ระหว่าง container และ host
docker cp <container_id>:/path/in/container ./local/path
docker cp ./local/file <container_id>:/path/in/container

# =============================================================================
# 🌐 5. การจัดการ Network
# =============================================================================

# ดู network ทั้งหมด
docker network ls

# สร้าง network ใหม่
docker network create mynetwork
docker network create --driver bridge mynetwork

# ดูรายละเอียด network
docker network inspect mynetwork

# ลบ network
docker network rm mynetwork

# เชื่อมต่อ container เข้ากับ network
docker network connect mynetwork <container_id>

# ตัดการเชื่อมต่อ container ออกจาก network
docker network disconnect mynetwork <container_id>

# ลบ network ที่ไม่ได้ใช้งาน
docker network prune

# =============================================================================
# 💾 6. การจัดการ Volumes
# =============================================================================

# ดู volume ทั้งหมด
docker volume ls

# สร้าง volume ใหม่
docker volume create myvolume

# ดูรายละเอียด volume
docker volume inspect myvolume

# ลบ volume
docker volume rm myvolume

# ลบ volume ที่ไม่ได้ใช้งาน
docker volume prune

# รัน container พร้อม mount volume
docker run -d -v myvolume:/data myapp
docker run -d -v $(pwd)/data:/data myapp  # bind mount

# =============================================================================
# 🧹 7. การทำความสะอาดระบบ (Cleanup)
# =============================================================================

# ลบทุกอย่างที่ไม่ใช้งาน (container, image, volume, network)
docker system prune

# ลบทุกอย่างรวม volume ด้วย
docker system prune -a --volumes

# ดูพื้นที่ที่ใช้งาน
docker system df

# ลบเฉพาะ container ที่หยุดทำงาน
docker container prune

# ลบเฉพาะ image ที่ไม่ได้ใช้งาน
docker image prune -a

# ลบเฉพาะ volume ที่ไม่ได้ใช้งาน
docker volume prune

# ลบเฉพาะ network ที่ไม่ได้ใช้งาน
docker network prune

# =============================================================================
# 📤 8. Docker Hub - Push และ Pull Images
# =============================================================================

# Login เข้า Docker Hub
docker login

# Tag image สำหรับ push
docker tag myapp:latest username/myapp:1.0.0

# Push image ขึ้น Docker Hub
docker push username/myapp:1.0.0

# Pull image จาก Docker Hub
docker pull username/myapp:1.0.0

# ดาวน์โหลด image จาก private registry
docker pull registry.example.com/myapp:1.0.0

# =============================================================================
# 🐙 9. Docker Compose Commands
# =============================================================================

# ตรวจสอบความถูกต้องของ docker-compose.yml
docker compose config

# รัน services ทั้งหมด
docker compose up

# รันแบบ background
docker compose up -d

# รันพร้อม build image ใหม่
docker compose up -d --build

# รันเฉพาะบาง services
docker compose up -d app mongodb

# ดู services ที่กำลังทำงาน
docker compose ps

# ดู log ของทุก services
docker compose logs

# ดู log แบบ realtime
docker compose logs -f

# ดู log ของ service เฉพาะ
docker compose logs -f app

# หยุด services ทั้งหมด
docker compose stop

# เริ่ม services ที่หยุดไว้
docker compose start

# รีสตาร์ท services
docker compose restart

# หยุดและลบ services ทั้งหมด
docker compose down

# หยุดและลบ services พร้อม volumes
docker compose down -v

# หยุดและลบ services พร้อม images
docker compose down --rmi all

# หยุดและลบทุกอย่าง
docker compose down --rmi all -v

# รันคำสั่งใน service
docker compose exec app sh
docker compose exec app npm test

# รัน service แบบ one-time command
docker compose run --rm app npm run migrate

# ดู resource usage ของ services
docker compose top

# Pull images ที่ใช้ใน compose
docker compose pull

# Build images จาก Dockerfile
docker compose build

# Build พร้อม no-cache
docker compose build --no-cache

# Scale services
docker compose up -d --scale app=3

# ใช้ไฟล์ compose อื่น
docker compose -f docker-compose.prod.yml up -d

# ใช้หลายไฟล์ compose รวมกัน
docker compose -f docker-compose.yml -f docker-compose.override.yml up -d

# ใช้ profile
docker compose --profile tools up -d

# =============================================================================
# 🛠️ 10. Dockerfile Build Commands
# =============================================================================

# Build จาก Dockerfile ใน directory ปัจจุบัน
docker build -t myapp .

# Build ด้วย tag หลายตัว
docker build -t myapp:latest -t myapp:1.0.0 .

# Build จาก Dockerfile อื่น
docker build -f Dockerfile.dev -t myapp:dev .

# Build ด้วย build arguments
docker build --build-arg NODE_ENV=production -t myapp .

# Build แบบ no-cache
docker build --no-cache -t myapp .

# Build เฉพาะ target stage (multi-stage)
docker build --target production -t myapp:prod .
docker build --target development -t myapp:dev .

# Build พร้อมแสดง output ทั้งหมด
docker build --progress=plain -t myapp .

# Build ด้วย platform ที่กำหนด
docker build --platform linux/amd64 -t myapp .
docker build --platform linux/arm64 -t myapp .

# Build สำหรับหลาย platforms (ต้องใช้ buildx)
docker buildx build --platform linux/amd64,linux/arm64 -t myapp .

# =============================================================================
# 🔐 11. Security Commands
# =============================================================================

# Scan image หาช่องโหว่ด้วย Docker Scout
docker scout cves myapp:latest
docker scout quickview myapp:latest

# ดูข้อมูล SBOM
docker sbom myapp:latest

# =============================================================================
# ⚡ 12. Performance & Optimization
# =============================================================================

# เปิดใช้งาน BuildKit (เร็วกว่า)
# Windows CMD:
# set DOCKER_BUILDKIT=1
# PowerShell:
# $env:DOCKER_BUILDKIT=1

# Build ด้วย BuildKit
DOCKER_BUILDKIT=1 docker build -t myapp .

# ดู disk usage ของ Docker
docker system df
docker system df -v  # แสดงรายละเอียด

# =============================================================================
# 📋 13. Useful Aliases (สำหรับใส่ใน .bashrc หรือ .zshrc)
# =============================================================================

# alias d='docker'
# alias dc='docker compose'
# alias dps='docker ps'
# alias dpsa='docker ps -a'
# alias dimg='docker images'
# alias dlog='docker logs -f'
# alias dexec='docker exec -it'
# alias dstop='docker stop $(docker ps -q)'
# alias drm='docker rm $(docker ps -aq)'
# alias drmi='docker rmi $(docker images -q)'
# alias dprune='docker system prune -af'

echo "🐳 Docker Commands Cheat Sheet loaded successfully!"

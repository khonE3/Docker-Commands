# 🐳 Docker Commands Cheat Sheet

> **สรุปคำสั่ง Docker ทั้งหมดที่ใช้บ่อย** พร้อมตัวอย่างและคำอธิบายภาษาไทย

---

## 📋 สารบัญ

- [1. ตรวจสอบระบบ](#-1-ตรวจสอบและตั้งคาระบบ)
- [2. จัดการ Images](#-2-การจัดการ-images)
- [3. จัดการ Containers](#-3-การจัดการ-containers)
- [4. ตรวจสอบ & Debug](#-4-ตรวจสอบและ-debug-containers)
- [5. Network](#-5-การจัดการ-network)
- [6. Volumes](#-6-การจัดการ-volumes)
- [7. Cleanup](#-7-การทำความสะอาดระบบ)
- [8. Docker Hub](#-8-docker-hub)
- [9. Docker Compose](#-9-docker-compose)
- [10. Dockerfile Build](#-10-dockerfile-build)

---

## 🔧 1. ตรวจสอบและตั้งค่าระบบ

| คำสั่ง | คำอธิบาย |
|--------|----------|
| `docker --version` | ตรวจสอบเวอร์ชัน Docker |
| `docker info` | ดูข้อมูลระบบ Docker |
| `docker compose version` | ตรวจสอบเวอร์ชัน Docker Compose |
| `docker login` | เข้าสู่ระบบ Docker Hub |
| `docker logout` | ออกจากระบบ Docker Hub |

---

## 📦 2. การจัดการ Images

### ดูรายการ Images

```bash
docker images              # ดู images ทั้งหมด
docker image ls            # เหมือนกับ docker images
docker image ls -a         # รวม intermediate images
```

### ดาวน์โหลด Images

```bash
docker pull nginx                  # ดึง nginx เวอร์ชันล่าสุด
docker pull node:20-alpine         # ดึง node เวอร์ชันที่ระบุ
docker pull mongo:7                # ดึง MongoDB 7
```

### สร้าง Images

```bash
docker build -t myapp .                          # build จาก Dockerfile
docker build -t myapp:1.0.0 .                    # build พร้อม tag version
docker build -f Dockerfile.dev -t myapp:dev .   # ใช้ Dockerfile อื่น
docker build --target production -t myapp .      # build เฉพาะ stage
docker build --no-cache -t myapp .               # build แบบไม่ใช้ cache
```

### จัดการ Images

| คำสั่ง | คำอธิบาย |
|--------|----------|
| `docker tag source target` | เปลี่ยนชื่อ/แท็ก image |
| `docker rmi <image>` | ลบ image |
| `docker rmi -f <image>` | บังคับลบ image |
| `docker image prune` | ลบ images ที่ไม่ใช้ |
| `docker image prune -a` | ลบ images ทั้งหมดที่ไม่ใช้ |
| `docker image inspect <image>` | ดูรายละเอียด image |
| `docker image history <image>` | ดูประวัติ layers |

---

## 🧱 3. การจัดการ Containers

### ดูรายการ Containers

```bash
docker ps                  # containers ที่กำลังรัน
docker ps -a               # containers ทั้งหมด
docker ps -q               # แสดงเฉพาะ ID
docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"
```

### รัน Containers

```bash
# รันพื้นฐาน
docker run nginx

# รันแบบ background (-d) พร้อม map port (-p)
docker run -d -p 8080:80 nginx

# รันพร้อมตั้งชื่อ (--name)
docker run -d -p 8080:80 --name web nginx

# รันพร้อม mount volume (-v)
docker run -d -p 8080:80 -v ./html:/usr/share/nginx/html nginx

# รันพร้อม environment variables (-e)
docker run -d -e NODE_ENV=production -e PORT=3000 myapp

# รันแบบ interactive (-it)
docker run -it node:alpine /bin/sh

# รันแล้วลบอัตโนมัติ (--rm)
docker run -it --rm node:alpine node
```

### จัดการ Lifecycle

| คำสั่ง | คำอธิบาย |
|--------|----------|
| `docker start <container>` | เริ่ม container ที่หยุดไว้ |
| `docker stop <container>` | หยุด container |
| `docker restart <container>` | รีสตาร์ท container |
| `docker kill <container>` | บังคับหยุด container |
| `docker rm <container>` | ลบ container |
| `docker rm -f <container>` | บังคับลบ (รวมที่กำลังรัน) |
| `docker container prune` | ลบ containers ที่หยุดทั้งหมด |

---

## 🔍 4. ตรวจสอบและ Debug Containers

### ดู Logs

```bash
docker logs <container>              # ดู logs ทั้งหมด
docker logs -f <container>           # ดู logs แบบ realtime
docker logs --tail 100 <container>   # 100 บรรทัดล่าสุด
docker logs --since 1h <container>   # logs ใน 1 ชม.ที่ผ่านมา
```

### เข้าถึง Container

```bash
docker exec -it <container> bash     # เข้า bash shell
docker exec -it <container> sh       # เข้า sh shell
docker exec <container> ls -la       # รันคำสั่งเดี่ยว
```

### ตรวจสอบ Container

| คำสั่ง | คำอธิบาย |
|--------|----------|
| `docker inspect <container>` | ดูรายละเอียดทั้งหมด |
| `docker top <container>` | ดู processes ที่รันอยู่ |
| `docker stats` | ดู CPU/Memory usage |
| `docker stats <container>` | ดู stats เฉพาะ container |

### คัดลอกไฟล์

```bash
# จาก container → host
docker cp <container>:/path/file ./local/

# จาก host → container
docker cp ./local/file <container>:/path/
```

### ดู IP Address

```bash
docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' <container>
```

---

## 🌐 5. การจัดการ Network

| คำสั่ง | คำอธิบาย |
|--------|----------|
| `docker network ls` | ดู networks ทั้งหมด |
| `docker network create mynet` | สร้าง network ใหม่ |
| `docker network inspect mynet` | ดูรายละเอียด network |
| `docker network rm mynet` | ลบ network |
| `docker network connect mynet <container>` | เชื่อมต่อ container |
| `docker network disconnect mynet <container>` | ตัดการเชื่อมต่อ |
| `docker network prune` | ลบ networks ที่ไม่ใช้ |

---

## 💾 6. การจัดการ Volumes

| คำสั่ง | คำอธิบาย |
|--------|----------|
| `docker volume ls` | ดู volumes ทั้งหมด |
| `docker volume create myvol` | สร้าง volume ใหม่ |
| `docker volume inspect myvol` | ดูรายละเอียด volume |
| `docker volume rm myvol` | ลบ volume |
| `docker volume prune` | ลบ volumes ที่ไม่ใช้ |

### Mount Volume

```bash
# Named volume
docker run -d -v myvol:/data myapp

# Bind mount
docker run -d -v $(pwd)/data:/data myapp

# Read-only mount
docker run -d -v ./config:/config:ro myapp
```

---

## 🧹 7. การทำความสะอาดระบบ

```bash
# ดูพื้นที่ที่ใช้งาน
docker system df
docker system df -v              # แสดงรายละเอียด

# ลบทุกอย่างที่ไม่ใช้
docker system prune              # containers, images, networks
docker system prune -a           # รวม images ทั้งหมด
docker system prune -a --volumes # รวม volumes ด้วย
```

| คำสั่ง | ลบอะไร |
|--------|--------|
| `docker container prune` | Containers ที่หยุดแล้ว |
| `docker image prune -a` | Images ที่ไม่ใช้ |
| `docker volume prune` | Volumes ที่ไม่ใช้ |
| `docker network prune` | Networks ที่ไม่ใช้ |

---

## 📤 8. Docker Hub

### Login & Push

```bash
# 1. Login
docker login

# 2. Tag image
docker tag myapp:latest username/myapp:1.0.0

# 3. Push
docker push username/myapp:1.0.0

# 4. Push หลาย tags
docker tag myapp username/myapp:latest
docker push username/myapp:latest
```

### Pull

```bash
docker pull username/myapp:1.0.0
docker pull registry.example.com/myapp:1.0.0  # private registry
```

---

## 🐙 9. Docker Compose

### คำสั่งพื้นฐาน

```bash
docker compose config            # ตรวจสอบ config
docker compose up                # รัน services
docker compose up -d             # รันแบบ background
docker compose up -d --build     # รันพร้อม build ใหม่
docker compose down              # หยุดและลบ services
docker compose down -v           # รวมลบ volumes
docker compose down --rmi all -v # ลบทุกอย่าง
```

### ดู Status & Logs

```bash
docker compose ps                # ดู services ที่รัน
docker compose logs              # ดู logs ทั้งหมด
docker compose logs -f           # logs แบบ realtime
docker compose logs -f app       # logs เฉพาะ service
docker compose top               # ดู processes
```

### จัดการ Services

```bash
docker compose start             # เริ่ม services
docker compose stop              # หยุด services
docker compose restart           # รีสตาร์ท services
docker compose exec app sh       # เข้า shell ของ service
docker compose run --rm app npm test  # รันคำสั่งใน service
```

### Advanced

```bash
# รันเฉพาะบาง services
docker compose up -d app mongodb

# Scale services
docker compose up -d --scale app=3

# ใช้ไฟล์ compose อื่น
docker compose -f docker-compose.prod.yml up -d

# ใช้หลายไฟล์รวมกัน
docker compose -f docker-compose.yml -f docker-compose.override.yml up -d

# ใช้ profile
docker compose --profile tools up -d

# Build images
docker compose build
docker compose build --no-cache

# Pull images
docker compose pull
```

---

## 🛠️ 10. Dockerfile Build

### Build Commands

```bash
# Build พื้นฐาน
docker build -t myapp .

# Build หลาย tags
docker build -t myapp:latest -t myapp:1.0.0 .

# Build จากไฟล์อื่น
docker build -f Dockerfile.dev -t myapp:dev .

# Build ด้วย arguments
docker build --build-arg NODE_ENV=production -t myapp .

# Build เฉพาะ target (multi-stage)
docker build --target production -t myapp:prod .

# Build แบบ no-cache
docker build --no-cache -t myapp .

# Build แสดง output ทั้งหมด
docker build --progress=plain -t myapp .

# Build สำหรับ platform อื่น
docker build --platform linux/amd64 -t myapp .

# Build หลาย platforms (ต้องใช้ buildx)
docker buildx build --platform linux/amd64,linux/arm64 -t myapp .
```

---

## ⚡ Tips & Tricks

### เปิด BuildKit (เร็วกว่า)

```bash
# Windows CMD
set DOCKER_BUILDKIT=1

# PowerShell
$env:DOCKER_BUILDKIT=1

# Linux/Mac
export DOCKER_BUILDKIT=1
```

### Useful Aliases

```bash
# เพิ่มใน .bashrc หรือ .zshrc
alias d='docker'
alias dc='docker compose'
alias dps='docker ps'
alias dpsa='docker ps -a'
alias dimg='docker images'
alias dlog='docker logs -f'
alias dexec='docker exec -it'
alias dstop='docker stop $(docker ps -q)'
alias drm='docker rm $(docker ps -aq)'
alias drmi='docker rmi $(docker images -q)'
alias dprune='docker system prune -af'
```

---

## 🔐 Security Commands

```bash
# Scan image หาช่องโหว่
docker scout cves myapp:latest
docker scout quickview myapp:latest

# ดูข้อมูล SBOM
docker sbom myapp:latest
```

---

<div align="center">

**Made with ❤️ for Docker learners**

</div>

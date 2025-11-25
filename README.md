
# 🐳 Docker Cheat Sheet ภาษาไทย
> **สรุปคำสั่งพื้นฐานที่ใช้บ่อยในโปรเจกต์จริง** เหมาะสำหรับมือใหม่และผู้ใช้ระดับกลาง

---

## 🧱 1. การตรวจสอบและตั้งค่าระบบ (System Info & Setup)

| คำสั่ง | คำอธิบาย |
|--------|-----------|
| `docker --version` | ตรวจสอบเวอร์ชันของ Docker |
| `docker info` | แสดงข้อมูลระบบ Docker เช่น จำนวน container, image |
| `docker login` | เข้าสู่ระบบ Docker Hub |
| `docker logout` | ออกจากระบบ Docker Hub |

---

## 📦 2. การจัดการ Images (Image Management)

| คำสั่ง | คำอธิบาย |
|--------|-----------|
| `docker images` | แสดงรายการ image ทั้งหมดที่มีอยู่ในเครื่อง |
| `docker pull <image>` | ดาวน์โหลด image จาก Docker Hub |
| `docker rmi <image>` | ลบ image ออกจากเครื่อง |
| `docker tag <source> <target>` | เปลี่ยนชื่อหรือแท็ก image |
| `docker build -t <name> .` | สร้าง image จาก Dockerfile |
| `docker image prune` | ลบ image ที่ไม่ได้ใช้งาน |

---

## 🧱 3. การจัดการ Containers (Container Lifecycle)

| คำสั่ง | คำอธิบาย |
|--------|-----------|
| `docker ps` | แสดง container ที่กำลังทำงาน |
| `docker ps -a` | แสดง container ทั้งหมด (รวมที่หยุดแล้ว) |
| `docker run <image>` | สร้างและรัน container ใหม่ |
| `docker run -d -p 8080:80 --name web nginx` | รันแบบ background และกำหนดชื่อ พร้อม map port |
| `docker start <container>` | เริ่ม container ที่หยุดไว้ |
| `docker stop <container>` | หยุด container |
| `docker restart <container>` | รีสตาร์ท container |
| `docker rm <container>` | ลบ container ที่หยุดแล้ว |
| `docker kill <container>` | บังคับหยุด container |
| `docker container prune` | ลบ container ที่หยุดทำงาน |

---

## 🧰 4. ตรวจสอบและเข้าใช้งาน Container (Inspection & Debug)

| คำสั่ง | คำอธิบาย |
|--------|-----------|
| `docker logs <container>` | ดู log ของ container |
| `docker logs -f <container>` | ดู log แบบ realtime |
| `docker exec -it <container> bash` | เข้า shell ภายใน container |
| `docker inspect <container>` | ดูรายละเอียดเต็มของ container (เช่น IP, volume) |
| `docker top <container>` | แสดง process ที่รันอยู่ใน container |

---

## 🌐 5. การจัดการ Network และ Volume

| คำสั่ง | คำอธิบาย |
|--------|-----------|
| `docker network ls` | แสดง network ทั้งหมด |
| `docker network inspect <name>` | ดูรายละเอียด network |
| `docker network create <name>` | สร้าง network ใหม่ |
| `docker volume ls` | แสดง volume ทั้งหมด |
| `docker volume inspect <name>` | ดูรายละเอียด volume |
| `docker volume rm <name>` | ลบ volume |
| `docker volume prune` | ลบ volume ที่ไม่ได้ใช้งาน |

---

## 🧹 6. การทำความสะอาดระบบ (Cleanup)

| คำสั่ง | คำอธิบาย |
|--------|-----------|
| `docker system prune` | ลบทุกอย่างที่ไม่ใช้งาน (container, image, volume, network) |
| `docker image prune` | ลบเฉพาะ image ที่ไม่ได้ใช้งาน |
| `docker container prune` | ลบ container ที่หยุดทำงาน |
| `docker volume prune` | ลบ volume ที่ไม่ได้ใช้งาน |

---

## 🧾 7. ความรู้พื้นฐานเกี่ยวกับ Dockerfile (Dockerfile Essentials)

### Dockerfile คืออะไร
- ไฟล์สคริปต์ที่บอกขั้นตอนการสร้าง Docker Image ทีละ Layer
- มักตั้งชื่อเป็น `Dockerfile` (ไม่มีนามสกุล) และวางไว้ที่รากของโปรเจกต์
- ใช้คำสั่ง `docker build -t <name> .` เพื่อสร้าง image จาก Dockerfile ในไดเรกทอรีปัจจุบัน

### โครงสร้างไฟล์ Dockerfile (Best Practices)
- กำหนด base image ด้วย `FROM`
- ตั้ง `WORKDIR` เพื่อกำหนดโฟลเดอร์ทำงานใน container
- คัดลอกไฟล์แบบเป็นขั้นตอนและใช้ `.dockerignore` ลดขยะ build context
- ติดตั้ง dependency ด้วย `RUN` และแยกขั้นตอนที่เปลี่ยนบ่อยเพื่อลด cache miss
- ใช้ `EXPOSE` เพื่อบ่งบอกพอร์ตที่ service ฟังอยู่ (เอกสาร ไม่ใช่บังคับเปิดพอร์ต)
- กำหนดคำสั่งเริ่มต้นด้วย `CMD` หรือ `ENTRYPOINT`
- ใช้ Multi-stage build เพื่อลดขนาด image ผลลัพธ์

### คำสั่งหลัก ๆ ของ Dockerfile
| คำสั่ง | ความหมาย |
|--------|-----------|
| `FROM` | ระบุ base image ที่จะใช้เริ่มต้น |
| `WORKDIR` | ตั้งค่าโฟลเดอร์ทำงานภายใน container |
| `COPY` | คัดลอกไฟล์/โฟลเดอร์จากเครื่อง host เข้า image |
| `ADD` | คล้าย COPY แต่รองรับ URL และไฟล์ tar (ควรใช้ COPY เป็นหลัก) |
| `RUN` | รันคำสั่งขณะ build เพื่อสร้าง layer ใหม่ |
| `CMD` | คำสั่งเริ่มต้นเมื่อ container ถูกรัน (แก้ไขได้ขณะแชร์รัน) |
| `ENTRYPOINT` | กำหนดคำสั่งหลักของ container ที่มักไม่เปลี่ยน |
| `EXPOSE` | ระบุพอร์ตที่แอปฟังอยู่ (เพื่อเอกสาร/เครื่องมือ) |
| `ENV` | ตั้งค่าตัวแปรสภาพแวดล้อมใน image |
| `ARG` | ตัวแปรเฉพาะช่วง build ใช้ร่วมกับ `--build-arg` |
| `USER` | ตั้งผู้ใช้ที่จะรันโปรเซสภายใน container |
| `HEALTHCHECK` | ตรวจสุขภาพของ service ภายใน container |
| `VOLUME` | ประกาศตำแหน่งข้อมูลที่ควรถูกเก็บบน volume |
| `LABEL` | ใส่ metadata ให้ image เช่น ผู้สร้าง เวอร์ชัน |

### ตัวอย่างการเขียน Dockerfile (Node.js Multi-stage)
```Dockerfile
# Stage 1: Build
FROM node:18-alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . .
# ถ้าเป็น TypeScript: RUN npm run build
# สำหรับแอป JS ธรรมดาอาจไม่ต้อง build

# Stage 2: Runtime (ขนาดเล็ก)
FROM node:18-alpine
WORKDIR /app
ENV NODE_ENV=production
COPY --from=builder /app /app
EXPOSE 3000
CMD ["node", "server.js"]
```

วิธี build และรัน (ตัวอย่าง):
```bash
docker build -t mynodeapp .
docker run -d -p 3000:3000 --name mynode mynodeapp
```
---

## 🧱 8. การใช้งาน Docker Compose (หลายบริการพร้อมกัน)

| คำสั่ง | คำอธิบาย |
|--------|-----------|
| `docker-compose up` | สร้างและรัน service จาก `docker-compose.yml` |
| `docker-compose up -d` | รันแบบ background |
| `docker-compose down` | หยุดและลบ service ทั้งหมด |
| `docker-compose ps` | แสดง service ที่กำลังทำงาน |
| `docker-compose logs -f` | ดู log ทั้งหมดแบบ realtime |

### โครงสร้างไฟล์ docker-compose.yml (Structure)
- version: เวอร์ชันสคีมา (เช่น '3' หรือ '3.9')
- services: รายการบริการต่าง ๆ ที่ต้องการรันร่วมกัน
- build/image: จะ build จาก Dockerfile หรือดึง image สำเร็จรูป
- ports: map พอร์ตจาก host:container
- environment: ตัวแปรสภาพแวดล้อม
- volumes: แม็ปโฟลเดอร์/ไฟล์เข้า container หรือใช้ named volumes
- networks: เครือข่ายภายในสำหรับคุยกันระหว่าง services
- depends_on: ลำดับการเริ่มต้นบริการที่ขึ้นต่อกัน

🧩 โครงสร้างตัวอย่าง (สั้น)
```yaml
version: '3.9'
services:
  app:
    build: .
    ports:
      - "3000:3000"
    environment:
      NODE_ENV: production
    volumes:
      - ./:/app
    depends_on:
      - db
  db:
    image: postgres:15-alpine
    environment:
      POSTGRES_PASSWORD: example
    volumes:
      - pgdata:/var/lib/postgresql/data
volumes:
  pgdata:
```

### Create docker-compose.yml for NGINX Web Server
```yaml
version: '3.9'
services:
  web:
    image: nginx:alpine
    container_name: nginx_web
    ports:
      - "8080:80"
    volumes:
      # แม็ปไฟล์ index.html ไปยังโฟลเดอร์เริ่มต้นของ NGINX
      - ./html:/usr/share/nginx/html:ro
    restart: unless-stopped
```
หมายเหตุ: สร้างโฟลเดอร์ `html/` และวางไฟล์ `index.html` ภายในเพื่อให้เว็บโหลดหน้าแรกจากโฮสต์

📝 **ตัวอย่างไฟล์ `docker-compose.yml`**
```yaml
version: '3'
services:
  web:
    image: nginx
    ports:
      - "8080:80"
  db:
    image: postgres
    environment:
      POSTGRES_PASSWORD: example
```

---

## ⚡ 9. ตัวอย่าง Workflow พื้นฐาน (มือใหม่ควรรู้)

```bash
# ดึง image
docker pull nginx

# สร้างและรัน container พร้อม port
docker run -d -p 8080:80 --name mynginx nginx

# ตรวจสอบสถานะ
docker ps

# ดู log
docker logs mynginx

# เข้าไปใน container
docker exec -it mynginx bash

# หยุดและลบ container
docker stop mynginx
docker rm mynginx
```
---

## 🚀 10. การ Tag Image และ Push ขึ้น Docker Hub

| คำสั่ง | คำอธิบาย |
|--------|-----------|
| `docker login` | เข้าสู่ระบบ Docker Hub ในเครื่อง |
| `docker tag <image>:<old_tag> <username>/<repo>:<new_tag>` | สร้างแท็กใหม่ให้ image เพื่อเตรียม push |
| `docker push <username>/<repo>:<tag>` | อัปโหลด image พร้อมแท็กขึ้น Docker Hub |
| `docker pull <username>/<repo>:<tag>` | ดาวน์โหลด image จาก Docker Hub |

ตัวอย่างขั้นตอนครบ (สมมุติ image ชื่อ `mynodeapp:latest` และ Docker Hub username คือ `iamsamitdev`):
```bash
# 1) เข้าสู่ระบบ Docker Hub
docker login

# 2) สร้างแท็กใหม่ในรูปแบบ <username>/<repo>:<tag>
docker tag mynodeapp:latest iamsamitdev/mynodeapp:1.0.0

# 3) Push image ขึ้น Docker Hub
docker push iamsamitdev/mynodeapp:1.0.0

# (ทางเลือก) ตั้งแท็กล่าสุดเป็น latest และ push ด้วย
docker tag mynodeapp:latest iamsamitdev/mynodeapp:latest
docker push iamsamitdev/mynodeapp:latest

# 4) ทดสอบ pull จากเครื่องอื่น
docker pull iamsamitdev/mynodeapp:1.0.0
```

เคล็ดลับ:
- ตั้งชื่อ repository ให้ตรงกับชื่อโปรเจกต์ และใช้ semantic version (เช่น `1.0.0`, `1.0.1`) เพื่อจัดการเวอร์ชันง่ายขึ้น
- ใช้แท็กที่ระบุสภาพแวดล้อม เช่น `:prod`, `:staging`, `:dev`
- ใน CI/CD แนะนำให้แท็กด้วย Git SHA หรือ build number เช่น `:sha-<shortsha>` เพื่อย้อนรอยได้

---
## 🐳 11. แนวทางการใช้ Docker ร่วมกับทีม เพื่อต่อยอดสู่ CI/CD ด้วย Jenkins Pipeline (Best Practices)

> คู่มือปฏิบัติสำหรับทีมพัฒนา ตั้งแต่การวางโครงสร้างงาน Docker ในเครื่องนักพัฒนา (dev) ไปจนถึงการ build-test-scan-push-deploy อัตโนมัติบน Jenkins อย่างปลอดภัยและทำซ้ำได้

---

## 🎯 เป้าหมาย
- ให้ทุกคนในทีม **รันแอปได้เหมือนกัน** (environment parity) ด้วย `docker compose`
- ลด “works on my machine” ด้วย **ภาพรวม workflow เดียวกัน** ตั้งแต่ dev → CI → prod
- ทำ **CI/CD บน Jenkins** ที่เร็ว, ปลอดภัย, มีเวอร์ชันนิ่ง และ rollback ได้

---
## 🧱 11.1. โครงสร้างโปรเจกต์ที่แนะนำ (Project Structure)

```
myapp/
├── docker-compose.yml          # สำหรับรันหลายบริการใน dev
├── Dockerfile                  # สำหรับ build image หลักของแอป
├── .dockerignore               # ลดขยะ build context
├── Jenkinsfile                 # Pipeline script สำหรับ Jenkins
├── src/                        # โค้ดแอปหลัก
│   ├── index.js
│   └── ...
├── tests/                      # โค้ดทดสอบ
│   ├── test_app.js
│   └── ...
├── scripts/                    # สคริปต์ช่วยเหลือต่าง ๆ
│   ├── setup_db.sh
│   └── ...
└── README.md                   # เอกสารโปรเจกต์
```
**แนวคิด**  
- แยก **compose สำหรับ dev** ออกจาก **ของ prod**  
- Dockerfile ใช้ **multi-stage** เพื่อลดขนาด image และแยกขั้นตอน build/test
---
## 🧪 11.2. Dev Workflow ด้วย Docker Compose

**หลักการ**
- Dev run ด้วย `docker compose up -d`  
- ใช้ **volume mount** เพื่อ hot reload (web/api)  
- Service dependency (db, cache) อยู่ใน compose เดียวกัน

**ตัวอย่าง `docker-compose.yml` (dev)**
```yaml
services:
  api:
    build: ./app
    command: npm run dev
    ports:
      - "4000:4000"
    volumes:
      - ./app:/usr/src/app
    env_file:
      - .env.development
    depends_on:
      - db

  db:
    image: postgres:16
    environment:
      POSTGRES_PASSWORD: devpass
    volumes:
      - pgdata:/var/lib/postgresql/data
    ports:
      - "5432:5432"

volumes:
  pgdata:
```

**คำสั่งรัน**
```bash
docker compose up -d
docker compose logs -f
```
---

## 🧩 11.3 Dockerfile Best Practices (สำคัญมาก)
- ✅ ใช้ multi-stage builds (แยก build stage และ runtime stage)
- ✅ ใช้ base image ที่เล็ก เช่น alpine/distroless (ถ้า tooling เพียงพอ)
- ✅ รันด้วย non-root user
- ✅ ระบุ เวอร์ชันชัดเจน (pin versions)
- ✅ ใส่ HEALTHCHECK ชัดเจน
- ✅ ใช้ .dockerignore เพื่อลด context
- ✅ อย่า bake secrets ลง image (ใช้ Jenkins Credentials/ARG/ENV อย่างถูกต้อง)

**ตัวอย่าง (Node.js)**

```Dockerfile
# ใช้ multi-stage build
# ---- Build stage ----
FROM node:20-alpine AS build
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . .
RUN npm run build

# ---- Runtime stage ----
FROM node:20-alpine
WORKDIR /app
ENV NODE_ENV=production
RUN addgroup -S app && adduser -S app -G app
COPY --from=build /app/dist ./dist
COPY package*.json ./
RUN npm ci --omit=dev && npm cache clean --force
USER app
EXPOSE 4000
HEALTHCHECK --interval=30s --timeout=5s --retries=3 CMD wget -qO- http://127.0.0.1:4000/health || exit 1
CMD ["node", "dist/server.js"]
```
---
## 🏷️ 11.4 Image Tagging & Registry Strategy
- ใช้ tagging แบบสื่อความหมาย:
  - `myapp:1.4.2` (SemVer)
  - `myapp:1.4.2-<git-sha>` (traceable)
  - `myapp:latest` เฉพาะ internal/non-prod
- แยก registry ต่อสภาพแวดล้อม (เช่น org-dev, org-prod) หรือแยก namespace
- เปิดใช้ immutability ของ tags (หรือ treat tags เป็น immutable ในทีม)
- เก็บ SBOM และ metadata (build info) ใน registry (เช่น OCI annotations)
---

## 🔐 11.5 Security & Compliance

- Scan images ทุกครั้งใน CI (เช่น Trivy)
- สร้าง SBOM (เช่น syft) และเก็บเป็น artifact
- เซ็น image (เช่น cosign) และ/หรือเปิดใช้ Docker Content Trust
- เก็บ secrets ใน Jenkins Credentials ไม่ commit ลง repo
- ใช้ network policy/least privilege (non-root, read-only FS ถ้าเป็นไปได้)

---
## 🧪 11.6 Testing Strategy ที่เข้ากับ Docker

- Unit Test: รันเร็ว ไม่ต้องใช้ container ก็ได้
- Integration Test: ใช้ฐานข้อมูล/บริการจำลองผ่าน container (แนะนำ Testcontainers)
- E2E Test: spin up stack ด้วย compose แล้วทดสอบจบเป็น scenario

---
## ⚡ 11.7 เร่งความเร็ว CI ด้วย Caching & BuildKit
- เปิด Docker BuildKit `(DOCKER_BUILDKIT=1)`
- ใช้ layer cache อย่างถูกต้อง (จัดลำดับ COPY/RUN ให้ cache-friendly)
- ใช้ buildx cache to registry เพื่อแชร์ cache ข้าม agent
- แยก stage test/build เพื่อ parallel เมื่อเหมาะสม

---
## 🛠️ 11.8 Jenkins Pipeline Design (CI/CD)
**แนวทางทั่วไป**
- Trigger ด้วย SCM Webhook (push/PR/merge)
- Stages: `checkout → lint/test → build → scan → push → deploy`
- ใช้ Credentials Binding สำหรับ REGISTRY, K8s, SSH
- แจ้งเตือนผลผ่าน Slack/Discord/Line/Email

**ตัวอย่าง Jenkinsfile (Declarative)**
```groovy
pipeline {
  agent any
  environment {
    REGISTRY    = 'registry.example.com/myteam'
    IMAGE_NAME  = 'myapp'
    GIT_SHA     = "${env.GIT_COMMIT[0..6]}"
    VERSION     = "1.4.2" // อาจอ่านจาก package.json หรือ git tag
    DOCKER_BUILDKIT = '1'
  }
  options { timestamps() }
  stages {

    stage('Checkout') {
      steps {
        checkout scm
        sh 'git rev-parse --short HEAD'
      }
    }

    stage('Install & Test') {
      steps {
        sh 'npm ci'
        sh 'npm run lint'
        sh 'npm test -- --ci'
      }
      post { always { junit 'reports/junit/*.xml' } }
    }

    stage('Build Image') {
      steps {
        script {
          sh """
            docker build \
              -t ${REGISTRY}/${IMAGE_NAME}:${VERSION}-${GIT_SHA} \
              -t ${REGISTRY}/${IMAGE_NAME}:${VERSION} \
              -t ${REGISTRY}/${IMAGE_NAME}:latest \
              .
          """
        }
      }
    }

    stage('Scan Image (Trivy)') {
      steps {
        sh """
          trivy image --exit-code 1 --severity CRITICAL,HIGH \
          ${REGISTRY}/${IMAGE_NAME}:${VERSION}-${GIT_SHA} || true
        """
      }
    }

    stage('Login & Push') {
      steps {
        withCredentials([usernamePassword(credentialsId: 'REGISTRY_CRED', usernameVariable: 'USER', passwordVariable: 'PASS')]) {
          sh """
            echo "$PASS" | docker login ${REGISTRY} -u "$USER" --password-stdin
            docker push ${REGISTRY}/${IMAGE_NAME}:${VERSION}-${GIT_SHA}
            docker push ${REGISTRY}/${IMAGE_NAME}:${VERSION}
            docker push ${REGISTRY}/${IMAGE_NAME}:latest
          """
        }
      }
    }

    stage('Deploy') {
      when { branch 'main' }
      steps {
        sh 'deploy/scripts/deploy.sh ${REGISTRY} ${IMAGE_NAME} ${VERSION}-${GIT_SHA}'
      }
    }
  }

  post {
    success { echo '✅ Build & Deploy Success' }
    failure { echo '❌ Build Failed' }
  }
}

```
> หมายเหตุ:
> - ใส่ trivy ใน agent หรือเรียกผ่าน container (เช่น docker run aquasec/trivy ...)
> - ถ้าใช้ Kubernetes แทน deploy.sh อาจใช้ kubectl set image/helm upgrade พร้อม --atomic เพื่อ rollback อัตโนมัติ

---
## 🔁 11.9 Deployment Patterns & Rollback
- Blue-Green / Canary (ผ่าน Load Balancer / Service Mesh / Helm)
- เก็บ artifact และ tags ของ release เพื่อ rollback เร็ว
- Health/Readiness Check + zero-downtime strategy
---

## 🧠 12. Tips & Tricks และ Best Practices

- ใช้ `.dockerignore` ลดขนาด build context และป้องกันไฟล์ไม่จำเป็นเข้า image
  - ตัวอย่างไฟล์ `.dockerignore`
    ```
    node_modules
    .git
    .DS_Store
    **/*.log
    dist
    __pycache__
    *.pyc
    ```
- สร้าง layer อย่างมีประสิทธิภาพ: รวมคำสั่ง `RUN` ที่เกี่ยวข้อง และจัดลำดับจากของที่เปลี่ยนน้อย → มาก เพื่อลด cache miss
- ใช้ Multi-stage build ลดขนาด image ผลลัพธ์ โดยคัดลอกเฉพาะ artifact ที่จำเป็นมายัง stage runtime
- ตั้ง user ที่ไม่ใช่ root ภายใน container เพื่อความปลอดภัย
  ```Dockerfile
  # ...
  RUN addgroup -S app && adduser -S app -G app
  USER app
  ```
- ระบุเวอร์ชัน image ให้ชัด (เช่น `nginx:1.25-alpine`) แทน `latest` เพื่อ build ได้ซ้ำเดิม
- ใช้ `HEALTHCHECK` เพื่อบอก orchestrator ว่าบริการพร้อมทำงานหรือไม่
  ```Dockerfile
  HEALTHCHECK --interval=30s --timeout=3s CMD wget -qO- http://localhost:3000/health || exit 1
  ```
- ใน Compose ใช้ `depends_on` ร่วมกับ `healthcheck` ของบริการที่พึ่งพา เพื่อรอให้พร้อมจริง
  ```yaml
  services:
    api:
      # ...
      depends_on:
        db:
          condition: service_healthy
    db:
      image: postgres:15-alpine
      healthcheck:
        test: ["CMD-SHELL", "pg_isready -U postgres"]
        interval: 10s
        timeout: 5s
        retries: 5
  ```
- จัดการ Volume อย่างมีวินัย: แยก data ที่ต้องคงอยู่ให้ชัด และใช้ named volumes สำหรับฐานข้อมูล
- ทำความสะอาดสิ่งที่ไม่ใช้ด้วย `docker system prune` เป็นระยะ (ระวังว่าจะลบ resource ที่ไม่ใช้งาน)
- Logging: ใช้ `docker logs -f <container>` ขณะดีบัก และตั้งค่า log driver ตามสภาพแวดล้อมการรันจริง

---

## 📚 แหล่งอ้างอิงแนะนำ
- [Docker Official Docs](https://docs.docker.com/)
- [Docker CLI Cheat Sheet](https://dockerlabs.collabnix.com/docker/cheatsheet/)
- [Play with Docker](https://labs.play-with-docker.com/)

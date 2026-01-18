# =============================================================================
# Dockerfile - Node.js Application
# =============================================================================
# คำอธิบาย: ไฟล์ Dockerfile สำหรับสร้าง Docker Image ของ Node.js Application
# ใช้เทคนิค Multi-stage Build เพื่อลดขนาด Image และเพิ่มความปลอดภัย
# =============================================================================

# -----------------------------------------------------------------------------
# Stage 1: Builder - ใช้สำหรับ Build Application
# -----------------------------------------------------------------------------
FROM node:20-alpine AS builder

# กำหนด Working Directory
WORKDIR /app

# คัดลอกไฟล์ package.json และ package-lock.json ก่อน (เพื่อใช้ประโยชน์จาก Docker Cache)
COPY package*.json ./

# ติดตั้ง Dependencies ทั้งหมด (รวม devDependencies สำหรับ build)
RUN npm ci

# คัดลอกไฟล์ทั้งหมดของโปรเจค
COPY . .

# Build Application (ถ้ามี build script)
# RUN npm run build

# -----------------------------------------------------------------------------
# Stage 2: Production - ใช้สำหรับ Runtime
# -----------------------------------------------------------------------------
FROM node:20-alpine AS production

# กำหนด Working Directory
WORKDIR /app

# ตั้งค่า Environment เป็น Production
ENV NODE_ENV=production

# สร้าง Non-root User เพื่อความปลอดภัย
RUN addgroup -S appgroup && adduser -S appuser -G appgroup

# คัดลอกไฟล์ที่จำเป็นจาก Builder Stage
COPY --from=builder /app/package*.json ./
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app .

# เปลี่ยนเป็น Non-root User
USER appuser

# ระบุ Port ที่ Application ใช้งาน
EXPOSE 3000

# กำหนด Health Check สำหรับ Container
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
    CMD wget --no-verbose --tries=1 --spider http://localhost:3000/health || exit 1

# คำสั่งเริ่มต้นเมื่อ Container ถูกรัน
CMD ["node", "index.js"]

# -----------------------------------------------------------------------------
# Stage 3: Development - ใช้สำหรับ Development (Optional)
# -----------------------------------------------------------------------------
FROM node:20-alpine AS development

# กำหนด Working Directory
WORKDIR /app

# ตั้งค่า Environment เป็น Development
ENV NODE_ENV=development

# คัดลอกไฟล์ package.json และ package-lock.json
COPY package*.json ./

# ติดตั้ง Dependencies ทั้งหมด รวม devDependencies
RUN npm install

# ติดตั้ง nodemon แบบ global สำหรับ hot reload
RUN npm install -g nodemon

# คัดลอกไฟล์ทั้งหมดของโปรเจค
COPY . .

# ระบุ Port ที่ Application ใช้งาน
EXPOSE 3000

# คำสั่งเริ่มต้นสำหรับ Development (ใช้ nodemon)
CMD ["npm", "run", "dev"]

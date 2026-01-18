/**
 * =============================================================================
 * Express.js Application - Docker Demo
 * =============================================================================
 * คำอธิบาย: ตัวอย่าง Node.js Application สำหรับใช้ร่วมกับ Docker
 * =============================================================================
 */

const express = require('express');
const app = express();

// กำหนด Port จาก Environment Variable หรือใช้ 3000 เป็นค่าเริ่มต้น
const PORT = process.env.PORT || 3000;

// Middleware สำหรับ parse JSON
app.use(express.json());

// =============================================================================
// Routes
// =============================================================================

/**
 * Health Check Endpoint
 * ใช้สำหรับ Docker HEALTHCHECK
 */
app.get('/health', (req, res) => {
    res.status(200).json({
        status: 'healthy',
        timestamp: new Date().toISOString(),
        uptime: process.uptime()
    });
});

/**
 * Root Endpoint
 */
app.get('/', (req, res) => {
    res.json({
        message: '🐳 Hello BakWave from Docker!',
        environment: process.env.NODE_ENV || 'development',
        version: '1.0.0'
    });
});

/**
 * API Info Endpoint
 */
app.get('/api', (req, res) => {
    res.json({
        name: 'Docker Demo API',
        version: '1.0.0',
        endpoints: [
            { method: 'GET', path: '/', description: 'Root endpoint' },
            { method: 'GET', path: '/health', description: 'Health check' },
            { method: 'GET', path: '/api', description: 'API information' }
        ]
    });
});

// =============================================================================
// Start Server
// =============================================================================
app.listen(PORT, '0.0.0.0', () => {
    console.log(`🚀 Server is running on http://localhost:${PORT}`);
    console.log(`📍 Environment: ${process.env.NODE_ENV || 'development'}`);
});

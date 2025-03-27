const express = require('express');
const https = require('https');
const fs = require('fs');
const path = require('path');

process.on('unhandledRejection', (reason, promise) => {
  console.error('Unhandled Rejection at:', promise, 'reason:', reason);
});

process.on('uncaughtException', (error) => {
  console.error('Uncaught Exception:', error);
});

try {
  console.log('Starting server...');
  
  const app = express();

  // Middleware to parse JSON
  app.use(express.json());

  // Load mock data
  const mockData = require('./db.json');

  // Define routes
  app.get('/users', (req, res) => {
    res.json(mockData.users || []);
  });

  app.get('/schedule', (req, res) => {
    res.json(mockData.schedule || []);
  });

  // SSL configuration
  const sslDir = path.join(__dirname, 'ssl');
  const keyPath = path.join(sslDir, 'localhost+2-key.pem');
  const certPath = path.join(sslDir, 'localhost+2.pem');
  
  console.log('Checking SSL files...');
  console.log('Key path:', keyPath);
  console.log('Cert path:', certPath);

  if (!fs.existsSync(keyPath)) {
    throw new Error(`SSL key file not found at: ${keyPath}`);
  }
  if (!fs.existsSync(certPath)) {
    throw new Error(`SSL certificate file not found at: ${certPath}`);
  }

  console.log('SSL files found');

  const httpsOptions = {
    key: fs.readFileSync(keyPath),
    cert: fs.readFileSync(certPath)
  };

  const port = 4000;
  console.log('Creating HTTPS server...');
  
  const server = https.createServer(httpsOptions, app);

  server.on('error', (error) => {
    console.error('Server error:', error);
  });

  server.listen(port, '0.0.0.0', () => {
    console.log('Server is listening...');
    console.log(`HTTPS Server running on:`);
    console.log(`- https://localhost:${port}`);
    console.log(`- https://192.168.86.30:${port}`);
  });

} catch (error) {
  console.error('Failed to start server:', error);
  process.exit(1);
}
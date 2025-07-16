const express = require('express');
const app = express();
const PORT = process.env.PORT || 3000;

// Middleware to parse JSON bodies
app.use(express.json());

// Simple test API route that returns plain text
app.get('/api/test', (req, res) => {
    res.set('Content-Type', 'text/plain');
    res.send('Hello! This is a test API endpoint returning plain text.');
});

// Root route
app.get('/', (req, res) => {
    res.set('Content-Type', 'text/plain');
    res.send('Server is running! Visit /api/test for the test endpoint. And also to test pipeline');
});

// Start the server
app.listen(PORT, () => {
    console.log(`Server is running on http://localhost:${PORT}`);
    console.log(`Test API available at http://localhost:${PORT}/api/test`);
});
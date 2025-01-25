const express = require('express');
const bodyParser = require('body-parser');
const cors = require('cors');
const connectDB = require('./config/db');

// Initialize app
const app = express();
const PORT = process.env.PORT || 5000;

// Middleware
app.use(bodyParser.json());
app.use(cors());

// Connect to database
connectDB();

// Routes
app.use('/api/users', require('./routes/userRoutes'));
app.use('/api/products', require('./routes/productRoutes'));
app.use('/api/orders', require('./routes/orderRoutes'));
app.use('/api/sales', require('./routes/salesRoutes'));
app.use('/api/inventory', require('./routes/inventoryRoutes'));

// Start server
app.listen(PORT, () => console.log(`Server running on http://localhost:${PORT}`));

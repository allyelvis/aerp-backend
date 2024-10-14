const express = require('express');
const mongoose = require('mongoose');
const dotenv = require('dotenv');
dotenv.config();

const app = express();

// Middleware
app.use(express.json());

// MongoDB connection
mongoose.connect(process.env.MONGO_URI, {
  useNewUrlParser: true,
  useUnifiedTopology: true,
}).then(() => console.log('MongoDB connected'))
  .catch((err) => console.log(err));

// Sample route
app.get('/', (req, res) => {
  res.send('AERP Backend API');
});

// Import product routes
const productRoutes = require('./routes/products');
app.use('/api/products', productRoutes);

// Listen on Port
const PORT = process.env.PORT || 5000;
app.listen(PORT, () => console.log(`Server running on port ${PORT}`));

// Import Auth and Orders Routes
const authRoutes = require('./routes/auth');
const orderRoutes = require('./routes/orders');

// Use Auth and Order Routes
app.use('/api/auth', authRoutes);
app.use('/api/orders', orderRoutes);

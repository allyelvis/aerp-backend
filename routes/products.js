const express = require('express');
const Product = require('../models/Product');
const router = express.Router();

// Create a new product
router.post('/', async (req, res) => {
  const { name, price, stock } = req.body;
  try {
    const newProduct = new Product({ name, price, stock });
    await newProduct.save();
    res.status(201).json(newProduct);
  } catch (err) {
    res.status(500).json({ error: 'Failed to create product' });
  }
});

// Get all products
router.get('/', async (req, res) => {
  try {
    const products = await Product.find();
    res.status(200).json(products);
  } catch (err) {
    res.status(500).json({ error: 'Failed to retrieve products' });
  }
});

module.exports = router;

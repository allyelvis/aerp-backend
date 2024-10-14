const express = require('express');
const { check, validationResult } = require('express-validator');
const auth = require('../middleware/auth');
const Order = require('../models/Order');

const router = express.Router();

// Create a new order
router.post(
  '/',
  auth,
  [
    check('products', 'Products are required').not().isEmpty(),
    check('totalAmount', 'Total amount is required').isNumeric(),
  ],
  async (req, res) => {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({ errors: errors.array() });
    }

    const { products, totalAmount } = req.body;

    try {
      const newOrder = new Order({
        user: req.user.id,
        products,
        totalAmount,
      });

      await newOrder.save();
      res.status(201).json(newOrder);
    } catch (err) {
      res.status(500).json({ error: 'Server error' });
    }
  }
);

// Get all orders for a user
router.get('/', auth, async (req, res) => {
  try {
    const orders = await Order.find({ user: req.user.id }).populate('products.product');
    res.status(200).json(orders);
  } catch (err) {
    res.status(500).json({ error: 'Server error' });
  }
});

module.exports = router;

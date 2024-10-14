const Product = require('../models/Product');

exports.createProduct = async (req, res) => {
    const { name, price, stock } = req.body;
    const product = new Product({ name, price, stock });
    await product.save();
    res.status(201).json(product);
};

exports.getProducts = async (req, res) => {
    const products = await Product.find();
    res.status(200).json(products);
};

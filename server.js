require('dotenv').config();
const express = require('express');
const bodyParser = require('body-parser');
const passport = require('./config/passport');
const connectDB = require('./config/db');

const app = express();
const PORT = process.env.PORT || 5000;

// Database connection
connectDB();

// Middleware
app.use(bodyParser.json());
app.use(require('express-session')({
  secret: process.env.SESSION_SECRET,
  resave: false,
  saveUninitialized: false,
}));
app.use(passport.initialize());
app.use(passport.session());

// Routes
app.use('/auth', require('./routes/authRoutes'));
app.use('/github', require('./routes/githubWebhook'));

// Start server
app.listen(PORT, () => console.log(`Server running on http://localhost:${PORT}`));

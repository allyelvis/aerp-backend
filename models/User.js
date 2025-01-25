const mongoose = require('mongoose');

const userSchema = new mongoose.Schema(
  {
    githubId: { type: String, unique: true, required: true },
    name: { type: String, required: true },
    email: { type: String, required: true },
    avatar: { type: String },
    tokens: { type: [String], default: [] },
    role: { type: String, enum: ['admin', 'user'], default: 'user' },
  },
  { timestamps: true }
);

module.exports = mongoose.model('User', userSchema);

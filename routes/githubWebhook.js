const express = require('express');
const crypto = require('crypto');

const router = express.Router();

router.post('/webhook', (req, res) => {
  const signature = 'sha256=' + crypto
    .createHmac('sha256', process.env.GITHUB_WEBHOOK_SECRET)
    .update(JSON.stringify(req.body))
    .digest('hex');

  const isVerified = signature === req.headers['x-hub-signature-256'];
  if (!isVerified) return res.status(403).json({ error: 'Invalid signature' });

  console.log('GitHub Webhook Event:', req.body);
  res.status(200).json({ success: true });
});

module.exports = router;

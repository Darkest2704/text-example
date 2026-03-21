const express = require('express');
const router = express.Router();
const authController = require('../controllers/authController');
const statusController = require('../controllers/statusController');

// Rutas solicitadas en el PDF
router.post('/login', authController.login);
router.post('/user-status', statusController.registerStatus);
router.get('/user-status/:id', statusController.getStatus);

module.exports = router;
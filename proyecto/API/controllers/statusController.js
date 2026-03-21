const db = require('../config/db');

exports.registerStatus = async (req, res) => {
    const { user_id, status_text } = req.body;

    // Validación de campos requeridos (Punto a.iv.2)
    if (!user_id || !status_text) {
        return res.status(400).json({ 
            success: false, 
            message: "Todos los campos son obligatorios" 
        });
    }

    try {
        const query = 'INSERT INTO user_status (user_id, status_text) VALUES (?, ?)';
        await db.execute(query, [user_id, status_text]);
        
        res.status(201).json({ 
            success: true, 
            message: "Nuevo estado de usuario registrado" // Punto a.iv.1
        });
    } catch (error) {
        res.status(500).json({ success: false, error: error.message });
    }
};

exports.getStatus = async (req, res) => {
    const userId = req.params.id;
    try {
        const query = 'SELECT status_text FROM user_status WHERE user_id = ? ORDER BY created_at DESC LIMIT 1';
        const [rows] = await db.execute(query, [userId]);
        
        if (rows.length > 0) {
            res.status(200).json({ success: true, status_text: rows[0].status_text });
        } else {
            res.status(404).json({ success: false, message: "No status found" });
        }
    } catch (error) {
        res.status(500).json({ success: false, error: error.message });
    }
};
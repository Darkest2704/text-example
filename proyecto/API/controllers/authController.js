const db = require('../config/db');

const login = async (req, res) => {
    try {
        const { email, password } = req.body;
        
        // Esto aparecerá en tu terminal de VS Code
        console.log(">>> Intento de login con:", email, password);

        const [rows] = await db.execute(
            'SELECT * FROM users WHERE email = ? AND password = ?',
            [email, password]
        );

        if (rows.length > 0) {
            console.log(">>> ¡Usuario encontrado!");
            res.status(200).json({ success: true, user: rows[0] });
        } else {
            console.log(">>> Credenciales no coinciden en la DB");
            res.status(401).json({ success: false, message: "Credenciales inválidas" });
        }
    } catch (error) {
        console.error(">>> Error en SQL:", error.message);
        res.status(500).json({ error: error.message });
    }
};

module.exports = { login };

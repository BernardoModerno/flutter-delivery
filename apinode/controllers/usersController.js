const User = require('../models/user');
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');
const keys = require('../config/keys');

module.exports = {

    login(req, res) {

        const email = req.body.email;
        const password = req.body.password;

        User.findByEmail(email, async (err, myUser) => {
            
            console.log('Error ', err);
            console.log('USUÁRIO ', myUser);

            if (err) {
                return res.status(501).json({
                    success: false,
                    message: 'Houve um error com o registro do usuário',
                    error: err
                });
            }

            if (!myUser) {
                return res.status(401).json({ // O cliente não tem autorização para realizar essa petição (401)
                    success: false,
                    message: 'O email não foi encontrado'
                });
            }

            const isPasswordValid = await bcrypt.compare(password, myUser.password);

            if (isPasswordValid) {
                const token = jwt.sign({id: myUser.id, email: myUser.email}, keys.secretOrKey, {});

                const data = {
                    id: `${myUser.id}`,
                    name: myUser.name,
                    lastname: myUser.lastname,
                    email: myUser.email,
                    phone: myUser.phone,
                    image: myUser.image,
                    session_token: `JWT ${token}`
                }

                return res.status(201).json({
                    success: true,
                    message: 'O usuário foi autenticado',
                    data: data // O ID do novo usuário que se registrou
                });

            }
            else {
                return res.status(401).json({ // O cliente não tem autorização para realizar essa petição (401)
                    success: false,
                    message: 'A senha está incorreta'
                });
            }

        });

    },

    register(req, res) {

        const user = req.body; // Captura os dados que o cliente envia
        User.create(user, (err, data) => {

            if (err) {
                return res.status(501).json({
                    success: false,
                    message: 'Houve um erro com o registro do usuário',
                    error: err
                });
            }

            return res.status(201).json({
                success: true,
                message: 'O registro se realizou corretamente',
                data: data // O ID do novo usuário que se registrou
            });

        });

    }

}
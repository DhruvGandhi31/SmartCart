const UserModel = require('../models/user_model');
const bcrypt = require('bcrypt');

const UserController = {

    createAccount: async function (req, res) {
        try {
            const userData = req.body;
            const newUser = new UserModel(userData);
            await newUser.save();

            return res.json({ success: true, data: newUser, message: "User created successfully" });

        } catch (error) {
            return res.json({ success: false, message: error });
        }
    },

    signIn: async function (req, res) {
        try {
            const { email, password } = req.body;
            const foundUser = await UserModel.findOne({
                email: email
            });

            if (!foundUser) {
                return res.status(404).json({ message: "User not found" });
            }

            const passwordsMatch = bcrypt.compareSync(password, foundUser.password);

            if (!passwordsMatch) {
                return res.json({ success: false, message: "Incorrect password" });
            }

            return res.json({ success: true, data: foundUser, message: "User signed in successfully" });

        } catch (error) {
            return res.json({ success: false, message: error });
        }
    },

    updateUser: async function (req, res) {
        try {
            const { id } = req.params;
            const userData = req.body;

            // Find the user by id and update the data
            const updatedUser = await UserModel.findByIdAndUpdate(id, userData, { new: true });

            if (!updatedUser) {
                return res.status(404).json({ message: "User not found" });
            }

            return res.json({ success: true, data: updatedUser, message: "User updated successfully" });
        } catch (error) {
            return res.json({ success: false, message: error });
        }
    }


};

module.exports = UserController;
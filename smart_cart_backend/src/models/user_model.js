const { Schema, model } = require('mongoose');
const uuid = require('uuid');
const bcrypt = require('bcrypt');

const userSchema = new Schema({
    id: { type: String, unique: true },
    fullName: { type: String, default: "" },
    email: { type: String, unique: true, required: true },
    password: { type: String, required: true },
    phoneNumber: { type: String, default: "" },
    address: { type: String, default: "" },
    city: { type: String, default: "" },
    state: { type: String, default: "" },
    profileProgress: { type: Number, default: 0 },
    updatedOn: { type: Date },
    createdOn: { type: Date }
});

userSchema.pre('save', function (next) {
    this.id = uuid.v1();
    this.updatedOn = Date.now();
    if (!this.createdOn) {
        this.createdOn = Date.now();
    }

    // if (this.password) {
    //     bcrypt.hash(this.password, 10, (err, hash) => {
    //         if (err) {
    //             return next(err);
    //         }
    //         this.password = hash;
    //         next();
    //     });
    // }
    const salt = bcrypt.genSaltSync(10);
    const hash = bcrypt.hashSync(this.password, salt);
    this.password = hash;
    next();
});

userSchema.pre(['update', 'findOneAndUpdate', 'updateOne'], function (next) {
    const update = this.getUpdate();
    delete update.id;
    delete update._id;

    this.updatedOn = Date.now();
    next();
});

const UserModel = model('User', userSchema);
module.exports = UserModel;
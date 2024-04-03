const { Schema, model } = require('mongoose');

const cartItemSchema = new Schema({
    product: { type: Schema.Types.ObjectId, ref: 'Product' },
    quantity: { type: Number, default: 1 }
});

const cartSchema = new Schema({
    user: { type: Schema.Types.ObjectId, ref: 'User', required: [true, 'user is required'] },
    items: { type: [cartItemSchema], default: [] },
    updatedOn: { type: Date },
    createdOn: { type: Date }
});

cartSchema.pre('save', function (next) {

    this.updatedOn = Date.now();
    this.createdOn = Date.now();

    next();
});

cartSchema.pre(['update', 'findOneAndUpdate', 'updateOne'], function (next) {
    const update = this.getUpdate();

    delete update._id;

    this.updatedOn = Date.now();
    next();
});

const CartModel = model('Cart', cartSchema);
module.exports = CartModel;
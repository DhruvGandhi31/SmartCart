const { Schema, model } = require('mongoose');

const orderItemSchema = new Schema({
    product: { type: Map, required: true },
    quantity: { type: Number, default: 1 }
});

const orderSchema = new Schema({
    user: { type: Map, required: [true, 'user is required'] },
    items: { type: [orderItemSchema], default: [] },
    status: { type: String, default: "pending" },
    updatedOn: { type: Date },
    createdOn: { type: Date }
});

orderSchema.pre('save', function (next) {

    this.updatedOn = Date.now();
    this.createdOn = Date.now();

    next();
});

orderSchema.pre(['update', 'findOneAndUpdate', 'updateOne'], function (next) {
    const update = this.getUpdate();

    delete update._id;

    this.updatedOn = Date.now();
    next();
});

const OrderModel = model('Order', orderSchema);
module.exports = OrderModel;
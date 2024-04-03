const { Schema, model } = require('mongoose');

const categorySchema = new Schema({
    title: { type: String, required: [true, 'title is required'] },
    description: { type: String, default: "" },
    updatedOn: { type: Date },
    createdOn: { type: Date }
});

categorySchema.pre('save', function (next) {

    this.updatedOn = Date.now();
    this.createdOn = Date.now();

    next();
});

categorySchema.pre(['update', 'findOneAndUpdate', 'updateOne'], function (next) {
    const update = this.getUpdate();

    delete update._id;

    this.updatedOn = Date.now();
    next();
});

const CategoryModel = model('Category', categorySchema);
module.exports = CategoryModel;
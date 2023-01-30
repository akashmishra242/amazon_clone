const { Schema, model } = require('mongoose');

const productStyleSchema = new Schema({
    styleid: { type: String, required: true, unique: true },
    title: { type: String, required: true },
    price: { type: Number, required: true },
    images: { type: Array, required: true }
});

const productStyleModel = model("ProductStyle", productStyleSchema);

module.exports = productStyleModel;
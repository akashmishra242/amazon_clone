const { Schema, model } = require('mongoose');
const uuid = require('uuid');

const cartItemSchema = new Schema({
    cartitemid: { type: String, default: uuid.v1 },
    cartid: { type: String, required: true },
    product: { type: Schema.Types.ObjectId, ref: "Product" },
    style: { type: Schema.Types.ObjectId, ref: "ProductStyle" },
    quantity: { type: Number, default: 1 },
    addedon: { type: Date, default: Date.now }
});

const cartItemModel = model("CartItem", cartItemSchema);

module.exports = cartItemModel;
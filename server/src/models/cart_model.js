const { Schema, model } = require('mongoose');
const uuid = require('uuid');

const cartSchema = new Schema({
    cartid: { type: String, default: uuid.v1 },
    userid: { type: String, required: true },
    items: { type: [{ type: Schema.Types.ObjectId, ref: "CartItem" }], default: [] }
});

const cartModel = model("Cart", cartSchema);

module.exports = cartModel;
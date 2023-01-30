const { Schema, model } = require('mongoose');
const uuid = require('uuid');

const orderSchema = new Schema({
    orderid: { type: String, default: uuid.v1 },
    user: { type: Schema.Types.ObjectId, ref: "User" },
    items: { type: Array, default: [] },
    status: { type: Number, default: 0 },
    addedon: { type: Date, default: Date.now }
});

const OrderModel = model("Order", orderSchema);

module.exports = OrderModel;
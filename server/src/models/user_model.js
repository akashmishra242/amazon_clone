const { Schema, model } = require('mongoose');
const uuid = require('uuid');

const userSchema = new Schema({
    userid: { type: String, unique: true, default: uuid.v1 },
    fullname: { type: String },
    email: { type: String, unique: true },
    phone: { type: String, unique: true },
    password: { type: String },

    address: { type: String, default: "" },
    country: { type: String, default: "" },
    city: { type: String, default: "" },
    pincode: { type: String, default: "" },

    token: { type: String, default: "" },

    addedon: { type: Date, default: Date.now }
});

const userModel = model("User", userSchema);

module.exports = userModel;
const express = require('express');
const app = express();
const mongoose = require('mongoose');
const bodyParser = require('body-parser');

app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: false }));
app.use(express.static('uploads'));

const constantkeys = require('./../constants');
mongoose.set('strictQuery', false);
mongoose.connect(constantkeys("mongodbconnectkey")).then(function () {

    app.get("/", function (req, res) {
        res.send("Server setup for amazon clone");
    });

    const userRoutes = require('./routes/user_routes');
    app.use("/api/user", userRoutes);

    const categoryRoutes = require('./routes/category_routes');
    app.use("/api/category", categoryRoutes);

    const productRoutes = require('./routes/product_routes');
    app.use("/api/product", productRoutes);

    const fileRoutes = require('./routes/file_routes');
    app.use("/api/file", fileRoutes);

    const orderRoutes = require('./routes/order_routes');
    app.use("/api/order", orderRoutes);

});

const PORT = 5000;
app.listen(PORT, function () {
    console.log(`Server started at PORT: ${PORT}`);
});
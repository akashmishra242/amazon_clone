const router = require('express').Router();
const OrderModel = require('./../models/order_model');

router.get("/:id", async function(req, res) {
    const id = req.params.id;
    await OrderModel.find({ user: id }).populate("user").exec(function(err, docs) {
        if(err) {
            res.json({ success: false, error: err });
            return;
        }

        res.json({ success: true, data: docs });
    });
});

router.post("/", async function(req, res) {
    const orderData = req.body;
    const newOrder = new OrderModel(orderData);
    await newOrder.save(function(err) {
        if(err) {
            res.json({ success: false, error: err });
            return;
        }

        res.json({ success: true, data: newOrder });
    });
});

router.put("/updatestatus", async function(req, res) {
    const orderData = req.body;
    const updatedOrder = await OrderModel.findOneAndUpdate({ orderid: orderData.orderid }, { status: orderData.status });

    if(!updatedOrder) {
        res.json({ success: false, error: "order-not-found" });
        return;
    }

    res.json({ success: true, data: orderData });
});

module.exports = router;
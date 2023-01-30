const router = require('express').Router();
const CategoryModel = require('./../models/category_model');

router.get("/", async function(req, res) {
    await CategoryModel.find().exec(function(err, categories) {
        if(err) {
            res.json({ success: false, error: err });
            return;
        }

        res.json({ success: true, data: categories });
    });
});

router.post("/", async function(req, res) {
    const categoryData = req.body;
    const newCategory = new CategoryModel(categoryData);
    await newCategory.save(function(err) {
        if(err) {
            res.json({ success: false, error: err });
            return;
        }

        res.json({ success: true, data: newCategory });
    });
});

router.delete("/", async function(req, res) {
    const categoryid = req.body.categoryid;
    const result = await CategoryModel.findOneAndDelete({ categoryid: categoryid });

    if(!result) {
        res.json({ success: false, error: "category-not-found" });
        return;
    }

    res.json({ success: true, data: result });
});

router.put("/", async function(req, res) {
    const categorydata = req.body;
    const categoryid = categorydata.categoryid;

    const result = await CategoryModel.findOneAndUpdate({ categoryid: categoryid }, categorydata);

    if(!result) {
        res.json({ success: false, error: "category-not-found" });
        return;
    }

    res.json({ success: true, data: categorydata });
});

module.exports = router;
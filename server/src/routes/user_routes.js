const router = require('express').Router();
const UserModel = require('./../models/user_model');
const bcrypt = require('bcrypt');
const CartModel = require('./../models/cart_model');
const CartItemModel = require('./../models/cart_item_model');
const jsonwebtoken = require('jsonwebtoken');
const jwt = require('./../middlewares/jwt');
const constantkeys = require('./../../constants');

router.get("/:userid", jwt, async function (req, res) {
    const userid = req.params.userid;
    const foundUser = await UserModel.findOne({ userid: userid });
    if (!foundUser) {
        res.json({ success: false, error: "user-not-found" });
        return;
    }
    res.json({ success: true, data: foundUser });
});

router.get("/:userid/viewcart", jwt, async function (req, res) {
    const userid = req.params.userid;
    const foundCart = await CartModel.findOne({ userid: userid }).populate({
        path: "items",
        populate: {
            path: "product style"
        }
    });
    if (!foundCart) {
        res.json({ success: false, error: "cart-not-found" });
        return;
    }

    res.json({ success: true, data: foundCart });
});

router.post("/createaccount", async function (req, res) {
    const userData = req.body;

    // Encrypt(Hash) the password
    const password = userData.password;
    const salt = await bcrypt.genSalt(10);
    const hashedPassword = await bcrypt.hash(password, salt);
    userData.password = hashedPassword;

    // Create the JWT Token
    const token = await jsonwebtoken.sign({ userid: userData.userid }, constantkeys("jwtsecretekey"));
    userData.token = token;

    const newUser = new UserModel(userData);
    await newUser.save(function (err) {
        if (err) {
            res.json({ success: false, error: err });
            return;
        }

        res.json({ success: true, data: newUser });
    });
});

router.post("/login", async function (req, res) {
    const email = req.body.email;
    const password = req.body.password;

    const foundUser = await UserModel.findOne({ email: email });
    if (!foundUser) {
        res.json({ success: false, error: "user-not-found" });
        return;
    }

    const correctPassword = await bcrypt.compare(password, foundUser.password);
    if (!correctPassword) {
        res.json({ success: false, error: "incorrect-password" });
        return;
    }

    res.json({ success: true, data: foundUser });
});


router.put("/updatepassword/:userid", async function (req, res) {
    const userdata = req.body;
    const newpassword = userdata.password;
    const userid = req.params.userid;
    const oldpassword = req.headers["old-password"];
    const confirmnewpassword = req.headers["confirm-new-password"];

    if (userdata.password == '' || oldpassword == '' || confirmnewpassword == '') {
        res.json({ success: false, error: "fill-all-mandatory-fields" });
        return;
    }
    if ([...newpassword].length < 6) {
        res.json({ success: false, error: "New Password must be atleast 6 digits" });
        return;
    }
    if ((newpassword === confirmnewpassword) == false) {
        res.json({ success: false, error: "New Password & Confirm new Password don't match." });
        return;
    }
    if (bcrypt.compare(newpassword, oldpassword) == false) {
        res.json({ success: false, error: "Enter correct old password" });
        return;
    }
    if (userdata.password != null) {
        // Encrypt(Hash) the password
        const password = userdata.password;
        const salt = await bcrypt.genSalt(10);
        const hashedPassword = await bcrypt.hash(password, salt);
        userdata.password = hashedPassword;
    }

    const result = await UserModel.findOneAndUpdate({ userid: userid }, userdata);

    if (!result) {
        res.json({ success: false, error: "user-not-found" });
        return;
    }

    res.json({ success: true, data: userdata });
});

router.put("/:userid", async function (req, res) {
    const userdata = req.body;
    const userid = req.params.userid;

    if (userdata.fullname == '' || userdata.phone == '' || userdata.email == '') {
        res.json({ success: false, error: "fill-all-mandatory-fields" });
        return;
    }
    const result = await UserModel.findOneAndUpdate({ userid: userid }, userdata);

    if (!result) {
        res.json({ success: false, error: "user-not-found" });
        return;
    }

    res.json({ success: true, data: userdata });
});

router.post("/:userid/addtocart", async function (req, res) {
    const userid = req.params.userid;
    const cartItemDetails = req.body;
    const userCart = await CartModel.findOne({ userid: userid });

    if (!userCart) {
        const newCartModel = new CartModel({ userid: userid, items: [] });
        await newCartModel.save(function (err) {
            if (err) {
                res.json({ success: false, error: err });
                return;
            }
        });

        cartItemDetails.cartid = newCartModel.cartid;
    }
    else {
        cartItemDetails.cartid = userCart.cartid;
    }

    const newCartItem = new CartItemModel(cartItemDetails);
    await newCartItem.save(async function (err) {
        if (err) {
            res.json({ success: false, error: err });
            return;
        }

        await CartModel.findOneAndUpdate({ cartid: newCartItem.cartid }, { $push: { items: newCartItem._id } });
        res.json({ success: true, data: newCartItem });
    });
});

router.delete("/:userid/removefromcart", async function (req, res) {
    const userid = req.params.userid;
    const cartItemDetails = req.body;

    const updatedCart = await CartModel.findOneAndUpdate({ userid: userid }, { $pull: { items: cartItemDetails.itemid } });
    if (!updatedCart) {
        res.json({ success: false, error: 'cart-not-exists' });
        return;
    }

    res.json({ success: true, data: cartItemDetails });
});

module.exports = router;
const jsonwebtoken = require('jsonwebtoken');
const constantkeys = require('./../../constants');

async function verify(req, res, next) {
    const authtoken = req.headers["auth-token"];
    const userid = req.headers["userid"];

    try {
        const result = await jsonwebtoken.verify(authtoken, constantkeys("jwtsecretekey"));
        if (result.userid == userid) {
            next();
        }
        else {
            res.json({ success: false, error: "access-denied" });
        }
    } catch (ex) {
        res.json({ success: false, error: "access-denied" });
    }
}

module.exports = verify;
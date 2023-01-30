const router = require('express').Router();
const upload = require('./../middlewares/file_upload');
const constantkeys = require('./../../constants');

router.post("/single", upload.single('image'), async function (req, res) {
    const uploadedFile = req.file;

    if (!uploadedFile) {
        res.json({ success: false, error: "file-not-uploaded" });
        return;
    }

    var link = '';
    link = constantkeys("deployedWebsite") == '' ? constantkeys("localhost") : constantkeys("deployedWebsite");
    res.json({ success: true, data: link + uploadedFile.filename });
});

router.post("/multiple", upload.array('images', 10), async function (req, res) {
    const uploadedFiles = req.files;

    if (!uploadedFiles || uploadedFiles.length == 0) {
        res.json({ success: false, error: "files-not-uploaded" });
        return;
    }

    var downloadurls = [];
    var link = '';
    link = constantkeys("deployedWebsite") == '' ? constantkeys("localhost") : constantkeys("deployedWebsite");
    uploadedFiles.forEach(function (uploadedFile) {
        const downloadurl = link + uploadedFile.filename;
        downloadurls.push(downloadurl);
    });

    res.json({ success: true, data: downloadurls });
});

module.exports = router;
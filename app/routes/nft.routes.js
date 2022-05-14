const controller = require("../controllers/nft.controller");
module.exports = function (app) {
    app.use(function (req, res, next) {
        res.header(
            "Access-Control-Allow-Headers",
            "x-access-token, Origin, Content-Type, Accept"
        );
        next();
    });

    app.get("/api/v1/silver/price", controller.getSilverPrice);
    app.get("/api/v1/gold/price", controller.getGoldPrice);
    app.get("/api/v1/platinum/price",  controller.getPlatinumPrice);
    app.get("/api/v1/passes",  controller.getPasses);
 
};

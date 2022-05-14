require("dotenv").config();
const request = require("request");
module.exports = function (app) {
    app.use(function (req, res, next) {
        res.header(
            "Access-Control-Allow-Headers",
            "x-access-token, Origin, Content-Type, Accept"
        );
        next();
    });



    
app.get("/", async (req,res)=>{
  request("http://localhost:3000/api/v1/passes",(err,response,body)=>{
  const passes = JSON.parse(body).data;
  res.render("components/home",{ 
    layout:"layouts/main",
    title:"Simple Mint Pass",
    data:passes,

    });
 });
});








};

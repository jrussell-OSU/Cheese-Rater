module.exports = function(){
    var express = require('express');
    var router = express.Router();


    function getProducts(res, mysql, context, complete){
        mysql.pool.query("SELECT product_name, type, brands.brand_name, description FROM products INNER JOIN brands ON brands.brand_ID = products.brand_ID", function(error, results, fields){
            if(error){
                res.write(JSON.stringify(error));
                res.end();
            }
            context.products = results;
            complete();
        });
    }


    router.get('/', function(req, res){
        var callbackCount = 0;
        var context = {};
        /*
        context.jsscripts = ["deleteperson.js","filterpeople.js","searchpeople.js"];
        */
        var mysql = req.app.get('mysql');
        getProducts(res, mysql, context, complete);
        function complete(){
            callbackCount++;
            if(callbackCount >= 1){
                res.render('products', context);
            }

        }
    });

    return router;
}();

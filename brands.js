module.exports = function(){
    var express = require('express');
    var router = express.Router();


    function getBrands(res, mysql, context, complete){
        mysql.pool.query("SELECT brand_name, country_of_origin, website FROM brands", function(error, results, fields){
            if(error){
                res.write(JSON.stringify(error));
                res.end();
            }
            context.brands = results;
            complete();
        });
    }


    router.get('/', function(req, res){
        var callbackCount = 0;
        var context = {};
        context.jsscripts = ["deleteperson.js","filterpeople.js","searchpeople.js"];
        var mysql = req.app.get('mysql');
        getBrands(res, mysql, context, complete);
        function complete(){
            callbackCount++;
            if(callbackCount >= 1){
                res.render('brands', context);
            }

        }
    });

    return router;
}();

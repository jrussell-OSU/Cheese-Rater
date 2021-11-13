module.exports = function(){
    var express = require('express');
    var router = express.Router();

    /*Retreives all Pairings. Uses brand_ID to display brand_name*/

    function getPairings(res, mysql, context, complete){
        mysql.pool.query("SELECT pairing_name, brands.brand_name FROM pairings INNER JOIN brands ON brands.brand_ID = pairings.brand_ID", function(error, results, fields){
            if(error){
                res.write(JSON.stringify(error));
                res.end();
            }
            context.pairings = results;
            complete();
        });
    }

    /*Used to get list of Brands for the dropdown when adding a new Pairing*/

    function getBrands(res, mysql, context, complete){
        mysql.pool.query("SELECT brand_ID, brand_name FROM brands", function(error, results, fields){
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
        var mysql = req.app.get('mysql');
        getPairings(res, mysql, context, complete);
        getBrands(res, mysql, context, complete);
        function complete(){
            callbackCount++;
            if(callbackCount >= 2){
                res.render('pairings', context);
            }

        }
    });

    /*Add a Pairing*/

    router.post('/', function(req, res){
        console.log(req.body); //for debugging purposes
        var mysql = req.app.get('mysql');
        var sql = "INSERT INTO pairings (pairing_name, brand_ID) VALUES (?,?)";
        var inserts = [req.body.pairing_name, req.body.brand_ID];
        sql = mysql.pool.query(sql,inserts,function(error, results, fields) {
            if(error){
                console.log(JSON.stringify(error));
                res.write(JSON.stringify(error));
                res.end();
            }else{
                res.redirect('/pairings');
            }
        });
    });

    return router;
}();

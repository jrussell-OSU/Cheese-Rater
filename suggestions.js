module.exports = function(){
    var express = require('express');
    var router = express.Router();

    /*Retreives all Reviews. Uses user_ID and product_ID to get user name and product name*/

    function getSuggestions(res, mysql, context, complete){
        mysql.pool.query("SELECT products.product_name, pairings.pairing_name, users.fname, users.lname, suggestion_date, comment FROM suggestions INNER JOIN products ON products.product_ID = suggestions.product_ID INNER JOIN pairings ON pairings.pairing_ID = suggestions.pairing_ID INNER JOIN users ON users.user_ID = suggestions.user_ID", function(error, results, fields){
            if(error){
                res.write(JSON.stringify(error));
                res.end();
            }
            context.suggestions = results;
            complete();
        });
    }

    /*Used to get list of Users for the dropdown when adding a new Suggestion*/

    function getUsers(res, mysql, context, complete){
        mysql.pool.query("SELECT user_ID, fname, lname FROM users", function(error, results, fields){
            if(error){
                res.write(JSON.stringify(error));
                res.end();
            }
            context.users = results;
            complete();
        });
    }

    /*Used to get list of Products for the dropdown when adding a new Suggestion*/

    function getProducts(res, mysql, context, complete){
        mysql.pool.query("SELECT product_ID, product_name FROM products", function(error, results, fields){
            if(error){
                res.write(JSON.stringify(error));
                res.end();
            }
            context.products = results;
            complete();
        });
    }

    /*Used to get list of Pairings for the dropdown when adding a new Suggestion*/

    function getPairings(res, mysql, context, complete){
        mysql.pool.query("SELECT pairing_ID, pairing_name FROM pairings", function(error, results, fields){
            if(error){
                res.write(JSON.stringify(error));
                res.end();
            }
            context.pairings = results;
            complete();
        });
    }

    /*Displays all Suggestions with user names, product names, and pairing names*/

    router.get('/', function(req, res){
        var callbackCount = 0;
        var context = {};
        var mysql = req.app.get('mysql');
        getProducts(res, mysql, context, complete);
        getUsers(res, mysql, context, complete);
        getPairings(res, mysql, context, complete);
        getSuggestions(res, mysql, context, complete);
        function complete(){
            callbackCount++;
            if(callbackCount >= 4){
                res.render('suggestions', context);
            }
        }
    });

    /*Add a Suggestion*/

    router.post('/', function(req, res){
        console.log(req.body); //for debugging purposes
        var mysql = req.app.get('mysql');
        var sql = "INSERT INTO suggestions (product_ID, pairing_ID, user_ID, comment) VALUES (?,?,?,?)";
        var inserts = [req.body.product_ID, req.body.pairing_ID, req.body.user_ID, req.body.comment];
        sql = mysql.pool.query(sql,inserts,function(error, results, fields) {
            if(error){
                console.log(JSON.stringify(error));
                res.write(JSON.stringify(error));
                res.end();
            }else{
                res.redirect('/suggestions');
            }
        });
    });

    return router;
}();

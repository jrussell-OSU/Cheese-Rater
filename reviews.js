module.exports = function(){
    var express = require('express');
    var router = express.Router();

    /*Retreives all Reviews. Uses user_ID and product_ID to get user name and product name*/

    function getReviews(res, mysql, context, complete){
        mysql.pool.query("SELECT users.fname, users.lname, products.product_name, rating, comment FROM reviews INNER JOIN users ON users.user_ID = reviews.user_ID INNER JOIN products ON products.product_ID = reviews.product_ID", function(error, results, fields){
            if(error){
                res.write(JSON.stringify(error));
                res.end();
            }
            context.reviews = results;
            complete();
        });
    }

    /*Used to get list of Users for the dropdown when adding a new Review*/

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

    /*Used to get list of Products for the dropdown when adding a new Review*/

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

    router.get('/', function(req, res){
        var callbackCount = 0;
        var context = {};
        var mysql = req.app.get('mysql');
        getProducts(res, mysql, context, complete);
        getUsers(res, mysql, context, complete);
        getReviews(res, mysql, context, complete);
        function complete(){
            callbackCount++;
            if(callbackCount >= 3){
                res.render('reviews', context);
            }

        }
    });

    /*Add a Review*/

    router.post('/', function(req, res){
        console.log(req.body); //for debugging purposes
        var mysql = req.app.get('mysql');
        var sql = "INSERT INTO reviews (user_ID, product_ID, rating, comment) VALUES (?,?,?,?)";
        var inserts = [req.body.user_ID, req.body.product_ID, req.body.rating, req.body.comment];
        sql = mysql.pool.query(sql,inserts,function(error, results, fields) {
            if(error){
                console.log(JSON.stringify(error));
                res.write(JSON.stringify(error));
                res.end();
            }else{
                res.redirect('/reviews');
            }
        });
    });

    return router;
}();

module.exports = function(){
    var express = require('express');
    var router = express.Router();

    /*Retrieve all Users from database*/

    function getUsers(res, mysql, context, complete){
        mysql.pool.query("SELECT fname, lname, email, password FROM users", function(error, results, fields){
            if(error){
                res.write(JSON.stringify(error));
                res.end();
            }
            context.users = results;
            complete();
        });
    }

    /*Display all Users*/

    router.get('/', function(req, res){
        var context = {};
        var mysql = req.app.get('mysql');
        getUsers(res, mysql, context, complete);
        function complete(){
                res.render('users', context);
            }
    });

    /*Add a User*/

    router.post('/', function(req, res){
        console.log(req.body); //for debugging purposes
        var mysql = req.app.get('mysql');
        var sql = "INSERT INTO users (fname, lname, email, password) VALUES (?,?,?,?)";
        var inserts = [req.body.fname, req.body.lname, req.body.email, req.body.password];
        sql = mysql.pool.query(sql,inserts,function(error, results, fields) {
            if(error){
                console.log(JSON.stringify(error));
                res.write(JSON.stringify(error));
                res.end();
            }else{
                res.redirect('/users');
            }
        });
    });

    return router;
}();

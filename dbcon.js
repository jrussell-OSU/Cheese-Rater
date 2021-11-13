var mysql = require('mysql');
var pool = mysql.createPool({
  connectionLimit : 10,
  host            : 'classmysql.engr.oregonstate.edu',
  user            : 'cs340_russelj2',
  password        : '9739',
  database        : 'cs340_russelj2'
});
module.exports.pool = pool;

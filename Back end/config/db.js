const mysql = require('mysql');

const db = mysql.createPool({
    host: 'localhost',
    user: 'root',
    database: 'clilnics_core'
})

db.getConnection(function(error) {
    if (error) {
        console.log(error);
        return;
    } else {
        console.log('Database is connected');
    }
});
// var dd = db.query("SELECT * FROM clinics_test.patient;", function(err, results) {
//     if (err) throw err;
//     // Send or render the results to the client
//     console.log(results)
//         // Alternatively, you can use res.render to render a template with the results
//         // res.render('users', {users: results});
// })


module.exports = db;
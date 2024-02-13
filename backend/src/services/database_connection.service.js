var mongoose = require('mongoose');

mongoose.connect('mongodb://127.0.0.1:27017/todo').then(() => console.log("Database is Connected.")).catch((error) => console.log(error));
const mongoose = require('mongoose');

const todoSchema = new mongoose.Schema({
    data: {
        type: String,
        required: true
    }
});

module.exports = mongoose.model('Todo', todoSchema);
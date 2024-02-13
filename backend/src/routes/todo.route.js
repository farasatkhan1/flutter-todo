var express = require('express');
var router = express.Router();

var TodoController = require('../controllers/todo.controller');

router.get('/', TodoController.getAllTodoItems);
router.get('/:id', TodoController.getSingleTodoItem);
router.post('/create', TodoController.create);
router.put('/update', TodoController.update);
router.delete('/delete', TodoController.delete);
router.delete('/clear', TodoController.clearAllItems);

module.exports = router;
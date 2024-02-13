var TodoModel = require('../models/todo.model');


exports.getAllTodoItems = async (req, res, next) => {
    try {

        const getAllTodoItems = await TodoModel.find({}).select("-__v");

        if (getAllTodoItems) {
            return res.status(200).json({getAllTodoItems});
        }

        return res.status(400).json({message: "Unable to retrieve todo items."});

    } catch (error) {
        console.error(error);
        return res.status(400).json({message: "Error occured while retrieving todo items."});
    }
}

exports.getSingleTodoItem = async (req, res, next) => {
    try {

        const getSingleTodoItem = await TodoModel.findById({_id: req.params.id});

        if (getSingleTodoItem) {
            return res.status(200).json({items: getSingleTodoItem});
        }

        return res.status(400).json({message: "Error occured while retrieving todo item"});

    } catch (error) {
        console.error(error);
        return re.status(400).json({message: "Error occured while retrieving an item."});
    }
}


exports.create = async (req, res, next) => {
    try {

        const { data } = req.body;

        const createTodoItem = await TodoModel.create({
            data: data
        });

        if (createTodoItem) {
            return res.status(201).json({message: "New Item is created.."});
        }

        return res.status(400).json({message: "Unable to create an item."});

    } catch (error) {
        console.error(error);
        return res.status(400).json({message: "Error occurred. Unable to create a new item."});
    } 
}

exports.update = async (req, res, next) => {
    try {

        const { id, data } = req.body;

        const updateTodoItem = await TodoModel.findByIdAndUpdate(
            {_id: id},
            {$set: {data: data}},
            {new: true}
        );

        if (updateTodoItem) {
            return res.status(200).json({message: updateTodoItem});
        }

        return res.status(400).json({message: "Error occured while updating todo item."});

    } catch (error) {
        console.error(error);
        return res.status(400).json({message: "Error occured while updating an item."});
    }
}

exports.delete = async (req, res, next) => {
    try {

        const { id } = req.body;

        const deleteTodoItem = await TodoModel.findByIdAndDelete({_id: id});

        if (deleteTodoItem) {
            return res.status(200).json({message: "An item is removed from todo items."});
        }

        return res.status(400).json({message: "Error occured while removing an item."});

    } catch (error) {
        console.error(error);
        return res.status(400).json({message: "Error occured while removing an item."});
    }
}

exports.clearAllItems = async (req, res, next) => {
    try {

        const deleteAllItems = await TodoModel.deleteMany({});

        if (deleteAllItems) {
            return res.status(200).json({message: "Removed all items"});
        }

        return res.status(400).json({message: "Error occured while deleting all items."});

    } catch (error) {
        console.error(error);
        return res.status(400).json({message: "Error occured while deleting all items."})
    }
}
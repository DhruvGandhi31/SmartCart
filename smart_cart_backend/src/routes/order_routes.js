const OrderRoutes = require('express').Router();
const OrderController = require('../controllers/order_controller');

OrderRoutes.post("/", OrderController.createOrder);
// OrderRoutes.get("/", OrderController.getOrders);
OrderRoutes.get("/:userId", OrderController.fetchOrderForUser);
OrderRoutes.put("/updateStatus", OrderController.updateOrderStatus);
// OrderRoutes.delete("/:id", OrderController.deleteOrder);




module.exports = OrderRoutes;
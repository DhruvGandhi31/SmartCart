const OrderModel = require('../models/order_model');

const OrderController = {
    createOrder: async function (req, res) {
        try {
            const { user, items } = req.body;
            const newOrder = new OrderModel({ user: user, items: items });
            await newOrder.save();

            return res.json({ success: true, data: newOrder, message: "Order created successfully" });

        } catch (error) {
            return res.json({ success: false, message: error });
        }
    },

    fetchOrderForUser: async function (req, res) {
        try {
            const userId = req.params.userId;
            const order = await OrderModel.findOne({
                'user.id': userId
            });

            if (!order) {
                return res.json({ success: false, message: "Order not found" });
            }

            return res.json({ success: true, data: order });

        } catch (error) {
            return res.json({ success: false, message: error });
        }
    },

    updateOrderStatus: async function (req, res) {
        try {
            const { orderId, status } = req.params.id;

            const updatedOrder = await OrderModel.findOneAndUpdate(
                { _id: orderId },
                { status: status },
                { new: true }
            );

            if (!updatedOrder) {
                return res.json({ success: false, message: "Order not found" });
            }

            return res.json({ success: true, data: updatedOrder, message: "Order updated successfully" });

        } catch (error) {
            return res.json({ success: false, message: error });
        }

    }
};

module.exports = OrderController;
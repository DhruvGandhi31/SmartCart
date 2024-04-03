const ProductRoutes = require('express').Router();
const ProductController = require('../controllers/product_controller');

ProductRoutes.post("/", ProductController.createProduct);
ProductRoutes.get("/", ProductController.getProducts);
ProductRoutes.get("/:id", ProductController.getProduct);
ProductRoutes.put("/:id", ProductController.updateProduct);
ProductRoutes.delete("/:id", ProductController.deleteProduct);
ProductRoutes.get("/category/:id", ProductController.fetchProductsByCategory);

module.exports = ProductRoutes;
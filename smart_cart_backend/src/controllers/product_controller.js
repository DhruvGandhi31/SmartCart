const ProductModel = require('../models/product_model');

const ProductController = {

    createProduct: async function (req, res) {
        try {
            const productData = req.body;
            const newProduct = new ProductModel(productData);
            await newProduct.save();

            return res.json({ success: true, data: newProduct, message: "Product created successfully" });

        } catch (error) {
            return res.json({ success: false, message: error });
        }
    },

    getProducts: async function (req, res) {
        try {
            const products = await ProductModel.find();
            return res.json({ success: true, data: products });

        } catch (error) {
            return res.json({ success: false, message: error });
        }
    },

    getProduct: async function (req, res) {
        try {
            const productId = req.params.id;
            const product = await ProductModel.findById(productId);

            if (!product) {
                return res.json({ success: false, message: "product not found" });
            }

            return res.json({ success: true, data: product });

        } catch (error) {
            return res.json({ success: false, message: error });
        }
    },

    updateProduct: async function (req, res) {
        try {
            const productId = req.params.id;
            const productData = req.body;
            const updatedProduct = await ProductModel.findByIdAndUpdate(productId, productData, { new: true });

            if (!updatedProduct) {
                return res.json({ success: false, message: "product not found" });
            }

            return res.json({ success: true, data: updatedProduct, message: "Product updated successfully" });

        } catch (error) {
            return res.json({ success: false, message: error });
        }
    },

    deleteProduct: async function (req, res) {
        try {
            const productId = req.params.id;
            const deletedProduct = await ProductModel.findByIdAndDelete(productId);

            if (!deletedProduct) {
                return res.json({ success: false, message: "product not found" });
            }

            return res.json({ success: true, data: deletedProduct, message: "Product deleted successfully" });

        } catch (error) {
            return res.json({ success: false, message: error });
        }
    },
    fetchProductsByCategory: async function (req, res) {
        try {
            const categoryId = req.params.id;

            // Fetch products associated with the category
            const products = await ProductModel.find({ category: categoryId });

            // Return the fetched products
            return res.json({ success: true, data: products });
        }
        catch (ex) {
            // Handle any errors that occur during the process
            return res.json({ success: false, message: ex });
        }
    }
};

module.exports = ProductController;
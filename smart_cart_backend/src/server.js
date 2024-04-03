const express = require('express');
const helmet = require('helmet');
const morgan = require('morgan');
const cors = require('cors');
const mongoose = require('mongoose');
const bodyParser = require('body-parser');

const app = express();
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));
app.use(helmet());
app.use(morgan('dev'));
app.use(cors());

mongoose.connect('mongodb+srv://realoxy1301:bl9N20kJiaTLK6A1@cluster0.p6p7gzb.mongodb.net/ecommerce?retryWrites=true&w=majority&appName=Cluster0');

const UserRoutes = require('./routes/user_routes');
app.use('/api/user', UserRoutes);

const CategoryRoutes = require('./routes/category_routes');
app.use('/api/category', CategoryRoutes);

const ProductRoutes = require('./routes/product_routes');
app.use('/api/product', ProductRoutes);

const CartRoutes = require('./routes/cart_routes');
app.use('/api/cart', CartRoutes);

const OrderRoutes = require('./routes/order_routes');
app.use('/api/order', OrderRoutes);

app.get('/', (req, res) => {
    res.send('E-commerce Backend API');
});

app.listen(3000, () => {
    console.log('Server listening on port 3000');
});
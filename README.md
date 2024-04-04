<!-- PROJECT LOGO -->
<br />
<div align="center">
  <a href="https://github.com/DhruvGandhi31/SmartCart">
    <img src="logo.png" alt="Logo" width="300" height="300">
  </a>
 
  <li>
      <a href="#Demo">View Demo</a>
      </li>
    

<!-- <h3 align="center">SmartCart</h3> -->

  <!-- <p align="center">
    project_description
    <br />
    
  </p> -->
</div>



<!-- TABLE OF CONTENTS -->
<details>
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
      <ul>
        <li><a href="#Features">Features</a></li>
      </ul>
      <ul>
        <li><a href="#built-with">Built With</a></li>
      </ul>
    </li>
    <li>
      <a href="#Demo">Demo Video</a>
      </li>
  </ol>
</details>



<!-- ABOUT THE PROJECT -->
## About The Project

<!-- [![Product Name Screen Shot][product-screenshot]](https://example.com) -->

SmarCart is an e-commerce application built to provide users with a seamless shopping experience. It offers a wide range of products across various categories, allowing users to browse, search, and purchase items effortlessly.

## Features

### User Authentication
- Secure user authentication system allowing users to sign up, log in, and manage their accounts.

### Product Catalog
- Extensive catalog of products with detailed information and images.

### Shopping Cart
- User-friendly shopping cart functionality for adding and managing items before checkout.

### Order Management
- Seamless order management system for tracking orders and order history.

### Wishlist
- Save favorite items for future reference.


### Note
I have used Provider and BLoC for state management in the same app to achieve features like local-state (Provider) management and global-state (BLoC) management. Provider is a simple and flexible state management solution for managing local-state within widgets. You can use Provider to manage the state of individual widgets or small parts of your UI. In this project, I have used Provider mainly for managing user state. BLoC is a state management pattern that separates the business logic from the UI. It's typically used for managing global application state and handling complex asynchronous operations. In this project, I have used bloc managing state of product and order. The bloc can fetch product data from an API and hold it in memory, allowing multiple widgets to access and display the same data without needing to refetch it. To integrate Provider and BLoC in the same app, I have used Provider to provide BLoCs to your widgets. 

The backend of SmartCart is deployed on Vercel, a cloud platform offering serverless functions and static site hosting.

### Built With
* ![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white)
* ![NodeJS](https://img.shields.io/badge/node.js-6DA55F?style=for-the-badge&logo=node.js&logoColor=white)
* ![MongoDB](https://img.shields.io/badge/MongoDB-%234ea94b.svg?style=for-the-badge&logo=mongodb&logoColor=white)
* ![Vercel](https://img.shields.io/badge/vercel-%23000000.svg?style=for-the-badge&logo=vercel&logoColor=white)


## Demo
https://github.com/DhruvGandhi31/SmartCart/assets/96539582/3b9b6e87-5b78-497b-939f-b26503d84967

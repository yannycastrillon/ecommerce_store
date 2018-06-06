# Ecommerce_store

### Description
An e-commerce store that sells a variety of products using server side framework Ruby on Rails.

| Home Page     | Category Page               |
|---------------|                             |
| ![](ecommerce_home.png)| ![](categories.png)|


## Functionalities
* Separates 'user' role for 'admins'.
  - Admin manages the products inventory, view orders, categories/subcategories and user's information on customers.
* Categories can be dynamically created by the admin (i.e. Science Fiction), and all products should be assigned to a category.
* Separate 'user' role for 'customers'.
  - Customers can purchase items only if they are registered users and are able to track status of their orders.
* Follows a standard practice for a shopping cart, and have appropriate search (using Solr) and filters on product pages (i.e. by category, by price).
* Able to create and manage the status of your orders.
* Uses `devise` power gem to manage user authentication.
* Follows a very easy to navigate interface.
(Bootstrap for front-end).

## Instructions to execute code

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

- Incorportate **Twillio Authy** for **2-factor** authentication during a purchase.
- Refactor to make code DRY.

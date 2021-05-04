# buyDeis
> buyDeis is an application designed to provide the Brandeis student body with a space for trading/selling items that they are no longer in need of. 

## Links
* Heroku: https://buydeis.herokuapp.com/
* Trello: https://trello.com/b/fnsJIQ6E/kanban-template
* Figma Prototype: https://www.figma.com/file/mBWOSr2oJdLQBINujVpqJB/SWE-project---2021?node-id=0%3A1
* Final Report Github Pages: https://fjj14.github.io/Resource_Matching/
* Presentation: https://docs.google.com/presentation/d/1T9kUSkWXx3vpSHea1BNmguWfBvuK2_Bm3LmZIwjy-ko/edit?ts=605e23bd#slide=id.gc7bd8fdc3a_0_4

## Table of contents
* [General info](#general-info)
* [Functionality and Features](#functionality)
* [URL Patterns](#url-patterns)
* [DB Schema](#db-schema)
* [Views](#views)
* [Key Models](#key-models)
* [APIs, Gems, Libraries](#APIs-Gems-Libraries)
* [Code Examples](#code-examples)
* [To-do list](#to-do-list)
* [Prototypes and Screenshots](#Prototypes-and-Screenshot)
* [Inspiration](#inspiration)
* [Creators](#creators)


## General info
More than just your ordinary platform for buying, trading and selling, buyDeis is an app designed to cater for Brandeis students to connect with each other through their presence of the creations and goods that they sell online. Every semester, people throw out perfectly good products just because they do not want to bring them home or simply do not need them. buyDeis aims to match resources for Brandeis people and help out students that cannot afford new products, as well as promote sustainability on our campus.

## Functionality 
When entering buyDeis, users are allowed to create posts to sell/trade and see the feed for items that are available for purchase or exchange. The platform allows users to message each other for products and socializing, and gives users the option to search for specific items or users. On top of that, users can perform transactions on products(in progress) and leave reviews for them so they can build credibility(in progress).

Our Features Include...
* The basic features
    * Sign up 
    * Sign in
    * Log out 
    * Profile page
* Specific to our project 
    * Homepage with feed of products
    * Create Product
    * Message
    * Search 
    * Stripe for transactions
    * like a product 
    * follow users
    * Shopping cart
    * Filtered search


## URL Patterns
* Home page page: /welcome
* Display the user registration page:  /signup
* Display user login prompt, and check for correct password: /login
* Display user logout prompt and allow user to end a session : /logout
* Display Full Text Search results: /search
* Create a product to post: /createProduct
* See all the conversations: /messages
* View one of the conversations: /conversations/conversationid
* View own user profile when logged in: /mypage
* Search form: /welcome/search
* Delete a product that was created: /delete 
* Users urls: /users, /users/new, /users/create, /users/delete, /users/1, /users/1/change, /users/1/update
* Categories urls: /categories,  /categories/1, /categories/new, /categories/1/edit
* Products urls:  /products,  /products/1, /products/new, /products/1/edit
* GIT Sessions urls: /sessions/new, /sessions



## DB Schema
* Users - first name(str), last name(str), email(str), password(str), username(str) 
* Products - name(str), description(str), price(float), user id(int), category id(int), status(boolean), quantity(int)
* Categories - name(str), description(str)
* cart 
* 

gems used in schema.rb
* Active Storage - storing images like profile pictures, product images
* Mailboxer - storing, sending, and receiving messages 

* User --> Product
    * In this relationship, a User can have many Products, and a Product can only belong to one User(a seller). It is a One-to-many Relationship.
* Category --> Product
    * In this relationship, a Category can have many products, and a Product can only have one Category. It is a Many-to-one Relationship.

## Views
* Implemented Views
    * views/conversations - shows conversations and messages between each other
    index and show occur side by side for ease of use
    index - Shows all conversations
    _sidebar - rendered in index 
    _indmessage - rendered in show
    show - shows the messages from users to each other  
    new - Display to start a new conversation 

    * views/layouts
    application - universal HTML code across our pages, calls _navbar and _footer
    _footer - partial for the bottom of our pages
    _navbar - top tab navigation partial

    * views/products - 
    edit - users can edit the product 
    index - where the card of each product is created
    _listAll - partial for listing all products posted, is called in welcome
    _form - partial for form to post a product online
    new - allows user to create/post a product, calls the _form partial 

     * views/sessions
    new - login page form
    
    * views/users
    mypage - profile page that shows profile picture, username, name, and cards of the products that they are selling 
    _form - partial for signup form 
    new-  signup page, form partial is called here
    index, show, edit  - users to list, destroy, edit  

    * views/welcome
    index - Where users are directed, shows all products posted with partial _listAll in products, <%= render '/products/listAll' %>

    * views/categories
    category filter for our search bar in navbar
    _form, index,new, show, edit 

* Planned Views
    * views/reviews
    new - fill out review form
    _form - form to be rendered in new
    index - displays a review card

    * views/transactions
    view for when transaction of a product occurs

## Key Models
* User
    * Fields: email, password_digest, username, first, last, admin, uid, provider, accesss_code, publishable_key, stripe_user_id, venmo_id
    * Associations:
        * Has_many products ( each user can post many products for sale/exchange)
        * Has_secure_password 
        * Has_one_attached image (profile picture)
        * Acts_as_messageable (each user can messenge other users)

* Product
    * Fields: name, image, description, price, user_id(the user who created it), category_id(the category it fits into).
    * Associations:
        * belongs_to User (he user who created it)
        * belongs_to Category ( the category it belongs to. For Example, Math textbook, would be in the books category)
        * Has_one_attached image (product picture)

* Categories
    * Fields:name, description 
    * Associations: 
        * Has_many products (Each category has many products that fit into the category)




## APIs, Gems, Libraries
* Mailboxer 
    * Allows any object created with a acts_as_messageable property to have a mailbox. This means they can send and receive messages. The can also have conversations with other users. This is implemented with the messages and conversations controllers and views
* Active Storage 
    * Allows us to upload files, in our case images, and store the data of the files. By default, it stores the data locally, which why we used google cloud to  store it on the cloud.
*Image_processing
    * Active storage variant
* Google Cloud Storage 
    * Used Google Cloud Storage and created a bucket to store all images uploaded on the site. Added this to our storage.yml file with the specific encryption data given by google so all images stored in the site are saved.
* Bcrypt 
    * Allows us to encrypt user passwords and ensures all user password created are correct

Other gems used
* faker 
* rubocop-faker
* puma 
* sass-rails for stylesheets
* webpacker
* turbolinks
* jbuilder
* jquery-rails
* font-awesome-rails
* bootsnap - Reduces boot times through caching; required in config/boot.rb
gems used for development and testing
* byebug
* web-console
* rack-mini-profiler
* listen
* spring
* capybara
* selenium-webdriver
* webdrivers
* pg

## To-do list:
* Transactions - use Stripe API to implement transactions 
* Reviews and Ratings - create a rating form for users to rate sellers for credibility - [see resource here](https://medium.com/@toodimes/how-to-implement-a-simple-5-star-rating-system-in-rails-using-native-bootstrap-48d5be205fdc)


## Prototypes and Screenshot
[View Figma Prototypes Here](./prototypes-figma.pdf)
![Screenshot of our product](./screenshot.png)

## Inspiration
[Depop](https://www.depop.com/),
[Poshmark](https://poshmark.com/)

## Creators
Created by [@fatumata](), [@yalda](), [@sophia]()


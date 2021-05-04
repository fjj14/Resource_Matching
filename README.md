# buyDeis
> buyDeis is an application designed to provide the Brandeis student body with a space for trading/selling items that they are no longer in need of. 

## Links
* Heroku: https://buydeis.herokuapp.com/
* Trello: https://trello.com/b/fnsJIQ6E/kanban-template
* Figma Prototype: https://www.figma.com/file/mBWOSr2oJdLQBINujVpqJB/SWE-project---2021?node-id=0%3A1
* Final Report Github Pages: https://fjj14.github.io/Resource_Matching/
* Presentation: https://docs.google.com/presentation/d/1Rre3mR8db8b0iWMTIdvfF3aqGnKtfwV2lCjRSk2-jq0/edit?usp=sharing
* Presentation (pdf): [Final Presentation -team 6.pdf](https://github.com/fjj14/Resource_Matching/files/6423002/Final.Presentation.-team.6.pdf)
* Brandeis Projects Text File: https://docs.google.com/document/d/1sMSO9wtyi5U4pwuYtg97mgm7SApaY_J9EpqQfEZ0o44/edit

## Table of contents
* [General info](#general-info)
* [Functionality and Features](#functionality)
* [URL Patterns](#url-patterns)
* [DB Schema](#db-schema)
* [Views](#views)
* [Key Models](#key-models)
* [APIs, Gems, Libraries](#APIs-Gems-Libraries)
* [Code Examples](#code-examples)
* [features we want to add in the future](#to-do-list)
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
* delete a product that was created: /delete 
* See all the conversations: /messages
* View one of the conversations: /conversations/conversationid
* View own user profile when logged in: /mypage
* Search form: /welcome/search
* add a product to the cart: add_to_cart
* display cart: /cart
* frontpage: /index
* search function: /search
* get user rating: /ratings/_form
* display likes on a product: like
* stripe: /stripe
* checkout to post the stripe dashboard: /checkout


## DB Schema
* Users - first(str), last (str), email(str), password(str), username(str), cart_id (int), admin(boolean), average_rating(int), stripe_user_id(int), balanace(int)
* Products - name(str), description(str), price(float), user id(int), category id(int), status(boolean), quantity(int), buyer_id(int), condition(str), conditon_id(int)
* Categories - name(str), description(str)
* conditions - name(str)
* carts - user_id(int)
* relationship - follower_id(int), followed_id(int)
* ratings - user_id(int), reviewer_id(int), rating_number(int), comment(str)
* mailboxer_receipts - receiver_type(str), receiver_id(int), nofitication_id(int), is_read(boolean), trashed(boolean), deleted(boolean), mailbox_type(str), is_delivered(boolean), delivery_method(str), message_id(str) 
* mailboxer_conversation_opt_outs - unsubscriber_type(str), unsubscriber_id(int), conversation_id(int)
* mailboxer_conversations - subject(str)
* mailboxer_notifications - type(str), body(text), subject(str), sender_type(str), sender_id(int), conversation_id(int), draft(boolean), notifcation_code(str), notified_object_type(str), notified_object_id(int), attachment(str), expires(datatime)
* line_items - product_id(bigint), cart_id(bigint), quantity(int)
* votes - votable_type(str), votable_id(int), voter_type(str), vote_flag(boolean), vote_scope(str), vote_weight(int)
* active_storage_attachments -  name(str), record_type(str), record_id(bigint), blob_id(bigint)
* active_storage_blobs -key (Str), filename(str), content_type(str), metadata(text), service_name(str), byte_size(bigint), checksum(str)
* active_storage_variant_reocrds - blob_id(bigint), variantion_digest(str)

## Relationships 
* User --> Product
* user --> rating
* user --> active_relationships
* user --> followers
* user --> followings
* user --> passive_relationships
* user belongs to cart
* product belongs to a user
* product belongs to category 
* product belongs to condition
* product --> attachment
* product --> line_items
* Category --> Product
* cart --> products
* cart --> lines_items
* cart belongs to a user 
* categories <--> products 
* condition <--> products 
* conversation <--> messages
* conversation <--> users
* conversation belongs to user
* lineItem belongs to product 
* lineItem belongs to cart
* message belongs to conversation
* message belongs to user
* rating belongs to user
* relationship belongs to follower
* relationship belongs to followed


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
* Mailboxer: Mailboxer allows any object created with a acts_as_messageable property to have a mailbox. This means they can send and receive messages. The can also have conversations with other users. This is implemented with the messages and conversations controllers and views
* Active storage: Active storage allows us to upload files, in our case images, and store the data of the files. By default, it stores the data locally, which why we used google cloud to  store it on the cloud.
* Google cloud storage: We used google cloud storage and created a bucket to store all images uploaded on the site. We added this to our storage.yml file with the specific encryption data given by google so all images stored in the site are saved.
* Bcrypt 
Allows us to encrypt user passwords and ensures all user password created are correct
* Stripe, omniauth-stripe-connect, oauth: These gems allowed us to connect with the stripe UI to integrate transactions. The oauth2/omniauth-stripe-connect allowed for authorization with these transactions
* Searchkick (with Elasticsearch): Searchkick allows for more advanced searching and filtering. It accounts for misspelled search input and incomplete input. It also allows for compound filtering with the products
* Acts_as_votable: Allows users to like/unlike a product and helps track number of likes and dislikes
* Cancancan, rails-admin: Allowed us to verify views. Users cannot see restricted views

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

## Features we want to add in the future:
* In app notification 
* New messages, follows and likes 
* Email notification
* When a new product is purchased 
* Comments on posts 
* Resetting  password 
* Using only Brandeis emails to sign up
* Trading



## Prototypes and Screenshot
[View Figma Prototypes Here](./prototypes-figma.pdf)
![Screenshot of our product](./screenshot.png)

## Inspiration
[Depop](https://www.depop.com/),
[Poshmark](https://poshmark.com/)

## Creators
Created by [@fatumata](), [@yalda](), [@sophia]()


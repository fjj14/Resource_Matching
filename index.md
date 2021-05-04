## buyDeis Final Report - SWE Capstone Project

You can check out our application [here](https://buydeis.herokuapp.com/).
Fatumata Jalloh, Yalda Mauj, Sophia Wang

### **What we did**
In the span of this semester of Spring 2021, we created an application for the Brandeis student body with a space for trading/selling items that they are no longer in need of. It is also a platform where students can connect with each other through their presence of the creations/goods that they sell online. 
On buyDeis, users can: 
* Sign up, Sign in, Log out safely
* Post a product to sell online, as well as edit and delete them
* Message sellers and buyers  
* Add products to shopping cart
* Buy products immediately 
* Like products
* Search with filters and typos
* Follow users
* Review users after purchasing


### **How we did it**
* We created our application through many gorails tutorials, ROR tutorials, stack overflow questions and research, office hours sessions, and pair programming sessions. We met every Wednesday with our TA, Julian, and also touched base on any bugs and issues we encountered. We also met after every Friday and Sunday to work on the project together and distribute tasks.  
Here are some specific technologies used for some main features:
* Sign up, Sign in, Log out safely - Bycrpt  
* Post a product to sell online, as well as edit and delete them - Active Storage, Google Cloud Storage, 
* Messaging sellers and buyers - Mailboxer gem
* Searching with filters and typos - Searchkick (with Elasticsearch)
* Liking products - Acts_as_votable
* Transactions, buying - Stripe


### **Why we did what we did**
* Sign up, Sign in, Log out safely - We wanted to allow users to have their platforms on buyDeis so they could message, post, and interact with items on the site. Hence, we allowed users to make accounts and make their presence known so they could create products and interact with other creatoers. We also wanted to make sure users were not in danger of their accounts being stolen, or logging in to accounts that they did not belong to
* Post a product to sell online, as well as edit and delete them - We wanted users to be able to easily go back to a product and edit any typos and updates to the item being posted, as well as delete if it is not on the market anymore. We also wanted to make sure they can upload multiple images to show, and have it displayed to potential buyers. 
* Messaging sellers and buyers - We wanted users to be able to not only interact about a product, but interact with each other as Brandeis students. That is why there are multiple ways to message on the site, regardless of if it is about the product or not. They can just say that they like their products!
* Searching with filters and typos - We wanted users to easily search for something without having to scroll through all products. We allow users to search with typo and filters like the condition of the product, the price range, etc. This way, if users make a mistake or want to search for specific items, we give them the option to.
* Liking products - We wanted users to be able to like products that they are interested and interact with the site as well as products.
* Transactions, buying - We wanted users to be able to purchase products safely using Stripe payments.


### **Challenges We Faced**
* Stripe was difficult to implement
* Each person had different experience levels coming in
* Sometimes the features one of us worked on would mess up other features, so communicating was important
* Being transparent about workloads for the week was sometimes hard



### **Future Plans**
This is not the end! In the future, we plan to implement:
*  in-app notification 
*  New messages, follows and likes 
*  Email notifications
*  Comments on posts 
*  Resetting  password 
*  Using one Brandeis email to sign up
*  A more sophisticated way of trading products


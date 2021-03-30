# Vending Machine

## Specs Given
* Once an item is selected and the appropriate amount of money is inserted, the vending machine should return the correct product
* The machine should return change if too much money is provided
* The machine should ask for more money if insufficient funds have been inserted
* The machine should take an initial load of products and change
* The change will be of denominations: 1p, 2p, 5p, 10p, 20p, 50p, £1, £2
* There should be a way of reloading products at a later point
* There should be a way of reloading change at a later point
* The machine should keep track of the products and change that it contains

## Run the App
TODO

## Run the Tests
TODO

## User Stories
**Version 1 - the basic machine**

- As a vending machine holder, I can initialise a vending machine with a list of products. Each product can have a set price.
- As a user, I can select an item from the vending machine if I insert enough money. The vending machine does not return change.
- As a user, I will be notified if I do not insert enough money in the vending machine for a certain product.
- As a vending machine holder, I can assume that the vending machine will be always stocked. We do not keep track of the amount of the product available.
- As a vending machine holder, I can see how much money we have received from items.

**Version 2 - the emptying machine**

- As a vending machine holder, I can initialise each product and fill it up unto the max capacity. The whole machine will have one maximum capacity that applies for each product. Each time a user takes a product with sufficient funds, the amount decreases.
- As a user, I will be notified if a product is not available.

**Version 3 - the machine that returns change**

- As a user, I receive change when I provide more money than the price of the product. This change is in denominations of: `1p, 2p, 5p, 10p, 20p, 50p, £1, £2`
- As a user, I will be notified if not enough money is available in the vending machine to provide return me. I will then receive the maximum amount of change available.

**Version 4 - the refillable machine**

- As a vending machine holder, I can refill products. When refilling, the amount of product available is again set at max capacity. Refilling can happen at any time.
- As a vending machine holder, I will be notified if I try refilling a product that is already at maximum capacity.
- As a vending machine holder, I can refill the money in the machine. There is no maximum limit to add money into the machine. I have the freedom to indicate how much I want to top up the money with.

## Assumptions and Decisions Made
- as soon as money enters the machine, we do not keep track of what type of coins are inserted. Returning change is then a possibility as long as we have enough funds available.
- The machine cannot go below a money value of 0.  If a user expects more change than is available in the machine, we do return the maximum we can provide. Alternatives would have been to
    - a) go in negative balance
    - b) just throw an exception stating no change could be returned
- If the instructions indicated the want for a UI, I would have very likely gone with a full Rails app on initialisation. This is because with the short time frame it would have been an easy way to set up an app that quickly lets you talk to the front end. However it explicitly stated not to think about the frontend, so I have opted for a more basic Ruby app setup.
- I'm going to assume that for this project we do not need to store any of the objects in a database.

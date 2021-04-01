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
The app currently has no UI to interact with. This has been done somewhat purposefully to focus on aspects that seemed more important to me; the actual functionality and the testing of said functionality. This does not mean you can not use the vending machine, to do so run from the command line:
```
$ irb
```

#### Set up the environment
  Setting up the environment can be done in either way:
  - **Start with a given setup**

  If you wish to not bother with setting up the environment, you can copy over the whole of `main.rb` into your `irb`. This initialises you with:
    - a `cash_holder`
    - a `vending_machine`
    - the products `snickers`, `mars` and `stroopwafels`.

  - **Start with a clean slate**

  If you wish to start with a completely new slate, you only need to add the following in your `irb`:
  ```
  require_relative 'lib/product'
  require_relative 'lib/vending_machine'
  require_relative 'lib/cash_holder'
  ```

  This ensures the objects are available to use. Here you can:
  - create products: `{product_name} = Product.new({product_name}, {product_price})`
  - create a cash holder: `cash_holder = CashHolder.new`.
  Creating a cash holder outside of the vending machine allows you to interact with it from the outside, like checking balance.
  - create a new vending machine: `vending_machine = VendingMachine.new({list_of_products}, {cash_holder})`

#### Interact with the machine
  _NOTE: only coins `1, 2, 5, 10, 20, 50, 100, 200` are accepted and are all displayed in pence._

  - As a vending machine user, you can do the following methods:
    - select an item: `vending_machine.select_item({product_name}, {list of coins})`.

  - As a vending machine holder, you can do the following methods:
    - see the balance of the cash holder: `cash_holder.get_total_value` (TODO to implement still)
    - refill the change that is in the cash holder: `cash_holder.top_up_coins({hash_of_coins})`.
    The hash of coins can look something like `{200 => 10, 100=> 5, 20 => 5}`
    - refill the stock of a certain product: `vending_machine.stock_product({product_name})`


## Run the Tests
1. **Running the whole test suite**

To run the full test suite, run on the home directory:
```
$ rspec
```

2. **Running one specific file**

To run one file in the test suite, run:
```
$ rspec {file_to_test}
Example: $ rspec spec/vending_machine_spec.rb
```

3. **Running one specific test**

To run one specific test in the test suite, run:
```
$ rspec {file_to_test}:{line_number_of_test}
Example: $ rspec spec/vending_machine_spec.rb:20
```

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

## Assumptions Made

- as soon as money enters the machine, we do not keep track of what type of coins are inserted. Returning change is then a possibility as long as we have enough funds available.
- The machine cannot go below a money value of 0.  If a user expects more change than is available in the machine, we do return the maximum we can provide. Alternatives would have been to
    - a) go in negative balance
    - b) just throw an exception stating no change could be returned
- If the instructions indicated the want for a UI, I would have very likely gone with a full Rails app on initialisation. This is because with the short time frame it would have been an easy way to set up an app that quickly lets you talk to the front end. However it explicitly stated not to think about the frontend, so I have opted for a more basic Ruby app setup.
- I'm going to assume that for this project we do not need to store any of the objects in a database.
- When returning change, we try to return as big as possible coins. Example: returning a change of `£2.50` will result in a coin of `£2` and a coin of `50p`.

## Decisions Made and Things to Improve On

- The money inserted and returned will be done in pence. Seeing money in pence avoids having to do any possible rounding or pretty printing and keeping the development easy. The drawback of this would be that there are countries that do not treat pence the same way (1000 cents in the dollar instead of 100), so this implementation would not work everywhere. Also is it not as user friendly to see `£1.50` as `150`, but it is a simpler implementation for the sake of the exercise.
- A vending machine normally works in a matrix. For simplicity's sake I have kept the ordering of the products in an array and we search on the product name. I can see an implementation where you would instead use codes for each product placement like `B4` or `D2` in the matrix.
- We assume all products in the vending machine are unique products and all have different names. It is currently possible to set up the machine with multiple products with the same name; in that case when selecting a product it will return the first product in the list. In the future we could check for uniqueness in a product list.
- To keep up momentum in development, I have opted to make the coins a hash map within `CashHolder`. I do appreciate this is not the neatest design, but it was to ensure all versions of the app were completed within the timeframe. More time permitted I would consider creating either a `Coin` or a `Wallet` instance that could confirm the validity of a coin and store a coins value and amount of each coin available. The `CashHolder` would then only need to occupy itself with calculating change given and the like.
- There are some errors raised and statements printed - I have kept them as is, but going forward I would like to encapsulate these in a `Printer` or a `Display` object. No other object then has to worry about how to show something to the user. This would also make it easier if we decide to move away from printing to STDOUT to somewhere else; we'd only need to update this `Display` object instead of making changes throughout the codebase.
- The app currently has no UI or interface to interact with. One of the first things I'd like to do, is either create a frontend for it or at least some interaction from the command line to make it more user friendly.
- Currently there is no distinction between users. A customer of the vending machine can now technically also top up the vending machine and see its balance, which we may want to restrict to special users that are vending machine holders. A way to expand this is to create a special User object where only when granted certain rights it can access certain behaviour.

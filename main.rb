require_relative 'lib/product'
require_relative 'lib/vending_machine'
require_relative 'lib/cash_holder'

# Initialising products
snickers = Product.new("snickers", 55)
twix = Product.new("twix", 80)
stroopwafels = Product.new("stroopwafels", 100)
inventory = [snickers, twix, stroopwafels]

# Initialising cash holder
cash_holder = CashHolder.new

# Initialising vending machine
vending_machine = VendingMachine.new(inventory, cash_holder)

product = vending_machine.select_product("twix", 80)
product = vending_machine.select_product("snickers", 100)

puts product.inspect
puts cash_holder.current_value

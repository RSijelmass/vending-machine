class VendingMachine
  def initialize(products, cash_holder = CashHolder.new)
    @products = products
    @cash_holder = cash_holder
  end

  def select_product(product_name, money_input)
    product = @products.detect { |product| product.name == product_name }

    raise "This item does not exist." unless product

    @cash_holder.store_funds(money_input)

    product.take_item
    product
  end
end

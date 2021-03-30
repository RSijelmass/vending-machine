class VendingMachine
  def initialize(products)
    @products = products
  end

  def select_product(product_name, money_input)
    product = @products.detect { |product| product.name == product_name }
    
    raise "This item does not exist." unless product
    raise "Not enough money provided." unless money_input >= product.price

    product
  end
end

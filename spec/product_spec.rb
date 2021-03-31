require 'product'

RSpec.describe Product do
  let(:name) { "someSnack" }
  let(:price) { 100 }
  let(:amount) { 10 }
  let(:product) { Product.new(name, price) }

  describe "#initialize" do
    it 'can fetch a product name' do
      expect(product.name).to eq name
    end
    it 'can fetch a product price' do
      expect(product.price).to eq price
    end
    it 'initialises with max capacity if no amount is given' do
      expect(product.amount).to eq Product::MAX_CAPACITY
    end
  end

  describe '#take_item' do
    it 'decreases the amount if enough items are available' do
      expect { product.take_item }.to change { product.amount }.by(-1)
    end
    it 'raises an error if not enough items are available' do
      empty_product = Product.new(name, price, 0)
      expect { empty_product.take_item }.to raise_error "Cannot take item; product is empty."
    end
  end

  describe '#replenish' do
    it 'fills up a product that is < max capacity to max capacity' do
      amount_below_max = Product::MAX_CAPACITY - 1
      product_below_max = Product.new(name, price, amount_below_max)
      expect{ product_below_max.replenish }
        .to change { product_below_max.amount }
        .to Product::MAX_CAPACITY
    end
    it 'keeps a product at max capacity to stay there' do
      product_at_max = Product.new(name, price)
      expect{ product_at_max.replenish }
        .to_not change { product_at_max.amount }
    end
  end
end

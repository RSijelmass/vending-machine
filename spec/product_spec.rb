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
end

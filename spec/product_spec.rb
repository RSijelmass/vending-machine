require 'product'

RSpec.describe Product do
  let(:name) { "someSnack" }
  let(:price) { 100 }
  let(:product) { Product.new(name, price) }

  it 'can fetch a product name' do
    expect(product.name).to eq name
  end
  it 'can fetch a product price' do
    expect(product.price).to eq price
  end
end

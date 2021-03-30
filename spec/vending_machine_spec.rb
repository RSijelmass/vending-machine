require 'vending_machine'

RSpec.describe VendingMachine do
  let(:snickers) { double("snickers", name: "snickers", price: 80) }
  let(:mars) { double("mars", name: "mars", price: 65) }
  let(:twix) { double("twix", name: "twix", price: 75) }
  let(:products) { [snickers, mars, twix] }
  let(:vending_machine) { VendingMachine.new(products) }

  describe 'select product' do
    it 'returns a product if I give enough money' do
        expect(vending_machine.select_product("snickers", 100)).to eq snickers
    end
    it 'throws an exception if I do not give enough money' do
      expect{ vending_machine.select_product("snickers", 5) }.to raise_exception("Not enough money provided.")
    end
    it 'throws an exception if I select a product that does not exist' do
      expect{ vending_machine.select_product("some-other-snack", 100) }.to raise_exception("This item does not exist.")
    end
  end
end

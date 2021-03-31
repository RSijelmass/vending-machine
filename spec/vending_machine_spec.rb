require 'vending_machine'

RSpec.describe VendingMachine do
  let(:snickers) { double("snickers", name: "snickers", price: 80, take_item: 0) }
  let(:mars) { double("mars", name: "mars", price: 65, take_item: 0) }
  let(:twix) { double("twix", name: "twix", price: 75, take_item: 0) }
  let(:products) { [snickers, mars, twix] }
  let(:cash_holder) { instance_double("cash_holder", current_value: 0) }
  let(:vending_machine) { VendingMachine.new(products, cash_holder) }

  describe 'select product' do
    before do
      allow(cash_holder).to receive(:store_funds)
      # allow(snickers).to receive(:take_item)
    end

    context 'with enough funds' do
      it 'returns a product' do
        expect(vending_machine.select_product("snickers", 100)).to eq snickers
      end
      it 'calls to CashHolder to #store_funds' do
        funds_to_store = 100
        expect(cash_holder).to receive(:store_funds).with(funds_to_store)
        vending_machine.select_product("snickers", funds_to_store)
      end
      it 'calls to product to take an item' do
        expect(snickers).to receive(:take_item)
        vending_machine.select_product("snickers", 100)
      end
    end

    context 'with non-acceptable funds' do
      it 'throws an exception if I do not give enough money' do
        expect{ vending_machine.select_product("snickers", 5) }
          .to raise_exception("Not enough money provided.")
      end
    end

    context 'with a non-existent product' do
      it 'throws an exception' do
        expect{ vending_machine.select_product("some-other-snack", 100) }
          .to raise_exception("This item does not exist.")
      end
    end
  end
end

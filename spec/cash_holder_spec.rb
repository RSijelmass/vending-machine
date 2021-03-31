require 'cash_holder'

RSpec.describe CashHolder do
  let(:input_value) { 500 }
  let(:cash_holder) { CashHolder.new(input_value) }
  describe 'initialise cash holder' do
    it 'can be intialised with an input value' do
      new_input_value = 100
      cash_holder = CashHolder.new(new_input_value)
      expect(cash_holder.current_value).to eq new_input_value
    end
    it 'can be initialised with no input value' do
      cash_holder = CashHolder.new
      expect(cash_holder.current_value).to eq 0
    end
  end

  describe '#store_funds' do
    let(:added_funds_over_price) { 58 }
    let(:added_funds_under_price) { 10 }
    let(:added_funds_negative) { -50 }
    let(:price_of_item) { 20 }
    let(:expected_change) { [20, 10, 5, 2, 1] }
    it 'updates the current_value with the price of the item' do
      expect { cash_holder.store_funds(added_funds_over_price, price_of_item) }
        .to change { cash_holder.current_value }.by(price_of_item)
    end
    it 'does not allow negative funds (taking funds out)' do
      expect { cash_holder.store_funds(added_funds_negative, price_of_item) }.to raise_error "No negative funds allowed."
    end
    it 'does not allow funds to be lower than the price of the item' do
      expect { cash_holder.store_funds(added_funds_under_price, price_of_item) }.to raise_error "Given funds cannot be less than the item price."
    end
    it 'returns any change if the added value is greater than the price of the item' do
      expect(cash_holder.store_funds(added_funds_over_price, price_of_item)).to eq expected_change
    end
  end
end

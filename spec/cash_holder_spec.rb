require 'cash_holder'

RSpec.describe CashHolder do
  let(:input_coins) { { 200 => 2, 100 => 2, 20 => 5, 10 => 5 } }
  let(:cash_holder) { CashHolder.new(input_coins) }
  describe 'initialise cash holder' do
    it 'can be intialised with an input value' do
      expect(cash_holder.coins_wallet).to eq input_coins
    end
    it 'can be initialised with no input value' do
      cash_holder = CashHolder.new
      expect(cash_holder.coins_wallet).to eq CashHolder::DEFAULT_COINS_INPUT
    end
  end

  describe '#store_funds' do
    let(:given_funds_over_price) { [20, 10, 10, 10, 5, 5] }
    let(:given_funds_under_price) { [5, 5] }
    let(:given_funds_negative) { [-10] }
    let(:given_funds_non_existent) { [35] }
    let(:price_of_item) { 25 }
    let(:expected_change) { [20, 10, 5] }
    it 'updates the current_value with the price of the item' do
      expected_increase_coins = []
      expect { cash_holder.store_funds(given_funds_over_price, price_of_item) }
        .to change { cash_holder.coins_wallet[10] }.by(2)
    end
    it 'does not allow negative funds (taking funds out)' do
      expect { cash_holder.store_funds(given_funds_negative, price_of_item) }.to raise_error "Some coins provided are not allowed."
    end
    it 'does not allow funds to be lower than the price of the item' do
      expect { cash_holder.store_funds(given_funds_under_price, price_of_item) }.to raise_error "Given funds cannot be less than the item price."
    end
    it 'returns any change if the added value is greater than the price of the item' do
      expect(cash_holder.store_funds(given_funds_over_price, price_of_item)).to eq expected_change
    end

    context 'not enough change to return' do
      let(:cash_holder_little_change) { CashHolder.new({200 => 1, 10 => 1, 2 => 3, 1 => 1}) }
      let(:given_funds) { [100] }
      let(:expected_change) { [10, 2, 2, 2, 1] }

      it 'returns the closest amount change available (rounded down)' do
        expect(cash_holder_little_change.store_funds(given_funds, price_of_item)).to eq expected_change
      end
    end
  end
end

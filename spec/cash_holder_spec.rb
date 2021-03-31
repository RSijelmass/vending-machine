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
    it 'updates the current_value with the input given' do
      added_value = 50
      expect { cash_holder.store_funds(added_value) }.to change { cash_holder.current_value }.by(added_value)
    end
    it 'does not allow negative funds (taking funds out)' do
      expect { cash_holder.store_funds(-50) }.to raise_error "No negative funds allowed."
    end
  end
end

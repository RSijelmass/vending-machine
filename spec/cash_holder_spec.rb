require 'cash_holder'

RSpec.describe CashHolder do

  describe 'initialise cash holder' do
    it 'can be intialised with an input value' do
      input_value = 500
      cash_holder = CashHolder.new(input_value)
      expect(cash_holder.current_value).to eq input_value
    end
    it 'can be initialised with no input value' do
      cash_holder = CashHolder.new
      expect(cash_holder.current_value).to eq 0
    end
  end

  describe '#store_funds' do
    xit 'updates the current_value with the input given' do

    end
    xit 'does not allow negative funds (taking funds out)' do

    end
  end
end

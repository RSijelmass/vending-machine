class CashHolder
  attr_reader :current_value
  
  def initialize(current_value=0)
    @current_value = current_value
  end
end

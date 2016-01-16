module WorldCurrencyConverter

	class Money
		MoneyError = Class.new(StandardError)
		DEFAULT_CURRENCY = 'EUR'
		DEFAULT_PRECISION = 2
		
		attr_reader :amount, :currency
		 



		  @@rates = {}
		  @@rates.default_proc = proc do |hash, key|
		    if hash[DEFAULT_CURRENCY].key?(key)
		      hash[key] = calculate_rates_for(key, hash[DEFAULT_CURRENCY])
		    else
		      fail MoneyError, "#{key} doesn't exist"
		    end
		  end

		  def self.conversion_rates(currency, rates)
		    @@rates.merge!(currency => rates)
		  end

		  def initialize(amount, currency = DEFAULT_CURRENCY)
		    @amount = amount
		    @currency = currency
		  end

		  def inspect
		    "#{'%.2f' % amount} #{currency}"
		  end

		  def amount
		    @amount % 2 == 0 ? @amount.to_int : @amount
		  end

		  def convert_to(curr)
		    return self if currency == curr

		    self.class.new(amount * @@rates[currency][curr], curr)
		  end

		  def ==(other)
		    with_precision(convert_to(DEFAULT_CURRENCY).amount) ==
		      with_precision(other.convert_to(DEFAULT_CURRENCY).amount)
		  end

		  def +(other)
		    new_amount = with_precision(convert_to(DEFAULT_CURRENCY).amount) +
		                 with_precision(other.convert_to(DEFAULT_CURRENCY).amount)

		    self.class.new(new_amount)
		  end

		  def -(other)
		    new_amount = with_precision(convert_to(DEFAULT_CURRENCY).amount) -
		                 with_precision(other.convert_to(DEFAULT_CURRENCY).amount)

		    self.class.new(new_amount)
		  end

		  def *(other)
		    new_amount = amount * other

		    self.class.new(new_amount, currency)
		  end

		  def /(other)
		    new_amount = amount / other

		    self.class.new(new_amount, currency)
		  end

		  def >(other)
		    with_precision(convert_to(DEFAULT_CURRENCY).amount) >
		      with_precision(other.convert_to(DEFAULT_CURRENCY).amount)
		  end

		  def <(other)
		    with_precision(convert_to(DEFAULT_CURRENCY).amount) <
		      with_precision(other.convert_to(DEFAULT_CURRENCY).amount)
		  end

		  protected

		  def self.calculate_rates_for(currency, default_rates)
		    result = default_rates.each_with_object({}) do |(curr, rate), calculated_rates|
		      next if curr == currency

		      new_rate = rate / default_rates[currency]
		      calculated_rates[curr] = new_rate
		    end

		    default_currency_rate = 1 / default_rates[currency]
		    result[DEFAULT_CURRENCY] = default_currency_rate
		    result
		  end

		  def with_precision(amount, precision = DEFAULT_PRECISION)
		    amount.round(precision)
		  end
	end
end

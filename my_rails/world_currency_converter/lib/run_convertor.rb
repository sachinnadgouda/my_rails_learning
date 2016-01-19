require 'world_currency_converter'

WorldCurrencyConverter::Money.conversion_rates('EUR', {
  'USD'     => 1.11,
  'Bitcoin' => 0.0047
})

usd = WorldCurrencyConverter::Money.new(22,"USD")
eur = usd.convert_to('EUR') # => 55.50 USD
puts usd.inspect
puts eur.inspect

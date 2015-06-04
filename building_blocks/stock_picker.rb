def stock_picker(stocks)
  if stocks[0] == stocks.max
    stocks.slice!(0)
    stock_picker(stocks)
  elsif stocks.max - stocks[0] > stocks.max - stocks[1] && stocks[1] != stocks.max
    stocks.slice!(1)
    stock_picker(stocks)
  elsif stocks.max - stocks[0] < stocks.max - stocks[1] && stocks[1] != stocks.max
    stocks.slice!(0)
    stock_picker(stocks)
  else
    print [stocks[0], stocks[1]]
  end
end

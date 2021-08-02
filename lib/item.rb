class Item
  attr_reader :name, :price
  def initialize(info)
   @name = info[:name]
   @price = info[:price].slice(1..4).to_f
 end
end

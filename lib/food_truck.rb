class FoodTruck
  attr_reader :name, :inventory
  def initialize(name)
    @name = name
    @inventory = {}
  end

  def check_stock(item)
    if @inventory.keys.include?(item)
      @inventory[item]
    else
      0
    end
  end

  def stock(item, quantity)
    if @inventory.keys.include?(item)
      @inventory[item] += quantity
    else
      @inventory[item] = quantity
    end
  end

  def items
    @inventory.keys
  end

  def potential_revenue
    total = 0
    @inventory.keys.each do |item|
      total += item.price * @inventory[item]
    end
    total
  end
end

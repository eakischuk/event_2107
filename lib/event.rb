class Event
  attr_reader :name, :food_trucks
  def initialize(name)
    @name = name
    @food_trucks = []
  end

  def add_food_truck(truck)
    @food_trucks << truck
  end

  def food_truck_names
    @food_trucks.map do |truck|
      truck.name
    end
  end

  def food_trucks_that_sell(item)
    sells = []
    @food_trucks.each do |truck|
      if truck.items.include?(item)
        sells << truck
      end
    end
    sells
  end

  def items_list
    @food_trucks.flat_map do |truck|
      truck.items
    end.uniq
  end

  def item_quantity(item)
    total = 0
    food_trucks_that_sell(item).each do |truck|
      total += truck.inventory[item]
    end
    total
  end

  def total_inventory
    inventory = {}
    items_list.each do |item|
      inventory[item] = {quantity: item_quantity(item), food_trucks: food_trucks_that_sell(item)}
    end
    inventory
  end
end

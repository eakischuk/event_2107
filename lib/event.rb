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
  end

  def total_inventory
    inventory = {}
  end
end

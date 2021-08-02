require './lib/item'
require './lib/food_truck'
require './lib/event'
require 'date'
require 'pry'

RSpec.describe Event do
  before(:each) do
    @event = Event.new("South Pearl Street Farmers Market")
    @food_truck1 = FoodTruck.new("Rocky Mountain Pies")
    @food_truck2 = FoodTruck.new("Ba-Nom-a-Nom")
    @food_truck3 = FoodTruck.new("Palisade Peach Shack")
    @item1 = Item.new({name: 'Peach Pie (Slice)', price: "$3.75"})
    @item2 = Item.new({name: 'Apple Pie (Slice)', price: '$2.50'})
    @item3 = Item.new({name: "Peach-Raspberry Nice Cream", price: "$5.30"})
    @item4 = Item.new({name: "Banana Nice Cream", price: "$4.25"})
    @food_truck1.stock(@item1, 35)
    @food_truck1.stock(@item2, 7)
    @food_truck2.stock(@item4, 50)
    @food_truck2.stock(@item3, 25)
    @food_truck3.stock(@item1, 65)
    @food_truck3.stock(@item3, 10)
  end

  it 'exists and has attributes' do
    expect(@event).to be_an(Event)
    expect(@event.name).to eq("South Pearl Street Farmers Market")
    expect(@event.food_trucks).to eq([])
  end

  it 'adds food trucks' do
    @event.add_food_truck(@food_truck1)
    @event.add_food_truck(@food_truck2)
    @event.add_food_truck(@food_truck3)
    expect(@event.food_trucks).to eq([@food_truck1, @food_truck2, @food_truck3])
  end

  it 'has food_truck names' do
    @event.add_food_truck(@food_truck1)
    @event.add_food_truck(@food_truck2)
    @event.add_food_truck(@food_truck3)
    expect(@event.food_truck_names).to eq(["Rocky Mountain Pies", "Ba-Nom-a-Nom", "Palisade Peach Shack"])
  end

  it 'has food trucks that sell a given item' do
    @event.add_food_truck(@food_truck1)
    @event.add_food_truck(@food_truck2)
    @event.add_food_truck(@food_truck3)
    expect(@event.food_trucks_that_sell(@item1)).to eq([@food_truck1, @food_truck3])
    expect(@event.food_trucks_that_sell(@item4)).to eq([@food_truck2])
  end

  it 'has items list' do
    @event.add_food_truck(@food_truck1)
    @event.add_food_truck(@food_truck2)
    @event.add_food_truck(@food_truck3)
    expect(@event.items_list).to eq([@item1, @item2, @item4, @item3])
  end

  it 'has quantity for given item' do
    @event.add_food_truck(@food_truck1)
    @event.add_food_truck(@food_truck2)
    @event.add_food_truck(@food_truck3)
    expect(@event.item_quantity(@item1)).to eq(100)
  end

  it 'has sorted items list' do
    @event.add_food_truck(@food_truck1)
    @event.add_food_truck(@food_truck2)
    @event.add_food_truck(@food_truck3)
    expect(@event.sorted_item_list).to eq(["Apple Pie (Slice)", "Banana Nice Cream", "Peach Pie (Slice)", "Peach-Raspberry Nice Cream"])
  end

  it 'has total inventory' do
    @event.add_food_truck(@food_truck1)
    @event.add_food_truck(@food_truck2)
    @event.add_food_truck(@food_truck3)
    result = {@item1 => {quantity: 100,
                         food_trucks: [@food_truck1, @food_truck3]
                       },
              @item2 => {quantity: 7,
                         food_trucks: [@food_truck1]
                        },
              @item4 => {quantity: 50,
                         food_trucks: [@food_truck2]
                       },
              @item3 => {quantity: 35,
                         food_trucks: [@food_truck2, @food_truck3]
                        }}


    expect(@event.total_inventory).to eq(result)
  end

  it 'has overstocked items' do
    @event.add_food_truck(@food_truck1)
    @event.add_food_truck(@food_truck2)
    @event.add_food_truck(@food_truck3)
    expect(@event.overstocked?(@item2)).to eq(false)
    expect(@event.overstocked?(@item1)).to eq(true)
    expect(@event.overstocked_items).to eq([@item1])
  end

  it 'has date' do
    allow(Date).to receive(:today).and_return("24/02/2020")
    expect(@event.date).to eq("24/02/2020")
  end
end

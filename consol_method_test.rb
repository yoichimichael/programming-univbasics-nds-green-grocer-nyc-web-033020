groceries = [
  {"AVOCADO" => {:price => 3.00, :clearance => true}},
  {"KALE" => {:price => 3.00, :clearance => false}},
  {"BLACK_BEANS" => {:price => 2.50, :clearance => false}},
  {"ALMONDS" => {:price => 9.00, :clearance => false}},
  {"TEMPEH" => {:price => 3.00, :clearance => true}},
  {"CHEESE" => {:price => 6.50, :clearance => false}},
  {"BEER" => {:price => 13.00, :clearance => false}},
  {"PEANUTBUTTER" => {:price => 3.00, :clearance => true}},
  {"BEETS" => {:price => 2.50, :clearance => false}}
]

def find_item_by_name_in_collection(name, collection)
  counter = 0
  while counter < collection.length do
    if collection[counter][:item] == name
      return collection[counter]
    end
    counter += 1
  end
end

def consolidate_cart(cart)
  new_array = []
  counter = 0
  while counter < cart.length do
    testing_item = find_item_by_name_in_collection(cart[counter][:item], new_array)
    if testing_item
      testing_item[:count] += 1
    else
      #new_item = add_count_key_to_hash(cart[counter])
      new_item = {
        :item => cart[counter][:item],
        :price => cart[counter][:price],
        :clearance => cart[counter][:clearance],
        :count => 1
      }
      new_array << new_item
    end
    counter += 1
  end
  new_array
end

#helper method for consolidate_cart
##takes in {}, returns {} with :counter=>1
def add_count_key_to_hash(hash)
  hash[:count] = 1
  hash
end

p find_item_by_name_in_collection("ZEBRA", groceries)
p find_item_by_name_in_collection("KALE", groceries)

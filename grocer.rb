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
      new_item = add_count_key_to_hash(cart[counter])
      #new_item = {
        #:item => cart[counter][:item],
        #:price => cart[counter][:price],
        #:clearance => cart[counter][:clearance],
        #:count => 1
      #}
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

def apply_coupons(cart, coupons)
  counter = 0
  while counter < coupons.length do
    cart_item = find_item_by_name_in_collection(coupons[counter][:item], cart)
    couponed_item_name = "#{coupons[counter][:item]} W/COUPON"
    cart_item_with_coupon = find_item_by_name_in_collection(couponed_item_name, cart)
    if cart_item && cart_item[:count] >= coupons[counter][:num]
      if cart_item_with_coupon
        cart_item_with_coupon[:count] += coupons[counter][:num]
        cart_item[:count] -= coupons[counter][:num]
      else
        cart_item_with_coupon = {
          :item => couponed_item_name,
          :price => coupons[counter][:cost] / coupons[counter][:num],
          :count => coupons[counter][:num],
          :clearance => cart_item[:clearance]
        }
        cart << cart_item_with_coupon
        cart_item[:count] -= coupons[counter][:num]
      end
    end
    counter += 1
  end
  cart
end

def apply_clearance(cart)
  counter = 0
  while counter < cart.length do
    if cart[counter][:clearance]
      cart[counter][:price] = (cart[counter][:price] - (cart[counter][:price] * 0.20)).round(2)
      #cart[counter][:price] = (cart[counter][:price] * 0.80).round(2)
    end
    counter += 1
  end
  cart
end

def checkout(cart, coupons)
  consolidated_cart = consolidate_cart(cart)
  coupons_applied = apply_coupons(consolidated_cart)
  final_cart = apply_clearance(coupons_applied)
  
  total = 0
  counter = 0
  while counter < final_cart.length do
    total += final_cart[counter][:price] * final_cart[counter][:count]
    counter += 1
  end
  if total > 100
    #total * 0.90
    total -= (total * 0.10)
  end    
  total
end

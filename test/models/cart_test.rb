require 'test_helper'

class CartTest < ActiveSupport::TestCase
	test "add unique products" do
		cart = Cart.create
		prod_1 = products(:one)
		prod_2 = products(:two)
		cart.add_product(prod_1.id).save!
		cart.add_product(prod_2.id).save!

		assert_equal 2, cart.line_items.size
		assert_equal prod_1.price + prod_2.price, cart.total_price
	end
		
	test "add duplicate products" do
		cart = Cart.create
		ruby = products(:ruby)
		cart.add_product(ruby.id).save!
		cart.add_product(ruby.id).save!

		assert_equal 1, cart.line_items.size
		assert_equal ruby.price*2, cart.total_price
	end
end

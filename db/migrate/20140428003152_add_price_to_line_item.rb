class AddPriceToLineItem < ActiveRecord::Migration
  def up
  	add_column :line_items, :product_price, :decimal, precision: 8, scale: 2
  	LineItem.all.each do |line_item|
  		line_item.product_price = line_item.product.price
  	end
  end

  def down
  	remove_column :line_items, :product_price
  end
end

require 'test_helper'

class ProductTest < ActiveSupport::TestCase
	fixtures :products
  
  # define quick function to create a product using the url as a param; for "image url" test
  def new_product(image_url)
  	Product.new(title: "My Book Title",
  				description: "yyy",
  				price: 1,
  				image_url: image_url)
  end

  test "product attributes must not be empty" do
  	product = Product.new
  	assert product.invalid?
  	assert product.errors[:title].any?
  	assert product.errors[:description].any?
  	assert product.errors[:price].any?
  	assert product.errors[:image_url].any?
  end

  test "product price must be positive" do
  	# create product with values
  	product = Product.new(title: "My Book Title",
  							description: "yyy",
  							image_url: "img.jpg")
  	# set price to -1
  	product.price = -1
  	
  	# assert that product should be invalid because of the price
  	assert product.invalid?

  	# same steps but for 0
  	product.price = 0
  	assert product.invalid?

  	# the price error shoud be same as the validation error text
  	assert_equal ["must be greater than or equal to 0.01"], product.errors[:price]

  	# change the price to a value > 0 and test that it's valid
  	product.price = 1
  	assert product.valid?
  end

  test "image url" do
  	# create array of valid image_url values
  	ok = %w{ fred.gif fred.jpg fred.png FRED.jpg FRED.Jpg http://a.b.c/x/y/x/fred.gif }
  	
  	# create array of invalid image_url values
  	bad = %w{ fred.doc frd.gif/more fred.gif.more }

  	# test that each name in ok is valid, include a message if it's not
  	ok.each do |name|
  		assert new_product(name).valid?, "#{name} should be valid"
  	end

  	# test that each in bad in invalid, include a message if it is valid
  	bad.each do |name|
  		assert new_product(name).invalid?, "#{name} should be invalid"
  	end
  end

  test "product is not valid without a unique title" do
  		# create product using values from Ruby record in products.yml
  		product = Product.new(title: products(:ruby).title,
  								description: "yyy",
  								price: 1,
  								image_url: "fred.gif")
  		# test that it's invalid
  		assert product.invalid?
  		# test that the title's error is because of the uniqueness 
  		assert_equal ["has already been taken"], product.errors[:title]
  end
end

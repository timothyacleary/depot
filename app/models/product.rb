class Product < ActiveRecord::Base
	has_many :line_items
	has_many :orders, through: :line_items

	# check that no line items contain the product before allowing delete
	before_destroy :ensure_not_referenced_by_line_item

	validates :title, :description, :image_url, presence: true
	validates :price, numericality: {greater_than_or_equal_to: 0.01} 
	validates :title, uniqueness: true
	validates :image_url, format: {
		with: %r{\.(gif|jpg|png)\Z}i,
		message: 'must be URL for GIF, JPG, or PNG image'
	}

	def self.latest
		Product.order(:updated_at).last
	end

	private

	def ensure_not_referenced_by_line_item
		if line_items.empty?
			return true
		else
			errors.add(:base, 'Line items present')
			return false
		end
	end
end

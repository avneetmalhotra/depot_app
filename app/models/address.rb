class Address < ApplicationRecord
  belongs_to :user

  with_options presence: true do
    validates :city, :state, :country, :pincode
  end

  validates :pincode, allow_blank: true, numericality: { only_integer: true}
end
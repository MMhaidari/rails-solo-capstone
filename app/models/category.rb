class Category < ApplicationRecord
  belongs_to :user
  has_many :transaction_categories
  has_many :transaction_entries, through: :transaction_categories

  validates :name, presence: true
  validates :icon, presence: true
end

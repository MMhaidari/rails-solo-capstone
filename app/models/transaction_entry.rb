class TransactionEntry < ApplicationRecord
  belongs_to :user
  has_many :transaction_categories
  has_many :categories, through: :transaction_categories

  accepts_nested_attributes_for :transaction_categories

  validates :name, presence: true
  validates :amount, presence: true
end

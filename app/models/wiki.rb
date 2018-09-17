class Wiki < ApplicationRecord
  belongs_to :user, optional: true

  validates :title, length: {minimum: 5}, presence: true
  validates :body, length: {minimum: 10}, presence: true
end

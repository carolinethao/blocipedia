class Wiki < ApplicationRecord
  belongs_to :user, optional: true

  validates :title, length: {minimum: 5}, presence: true
  validates :body, length: {minimum: 10}, presence: true
  validates :user, presence: true

  after_initialize :set_public, if: :new_record?

  def set_public
      self.private = false if self.private == nil
  end
end

class User < ApplicationRecord
  enum role: [:standard, :premium, :admin]

  before_save { self.role ||= :standard }

  has_many :wikis, dependent: :destroy

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :confirmable, :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable
end

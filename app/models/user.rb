class User < ApplicationRecord
  enum role: [:standard, :premium, :admin]

  before_save { self.email = email.downcase if email.present? }
  before_save { self.role ||= :standard }

  after_update :downgrade_wikis, if: :standard?

  has_many :wikis, dependent: :destroy

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :confirmable, :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  def downgrade_wikis
    self.wikis.update_all(private: false)
  end

end

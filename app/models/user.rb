class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum role: { customer: 'customer', client: 'client', admin: 'admin' }
  has_many :shops
  has_many :bookings
  after_initialize :set_default_role, if: :new_record?

  private

  def set_default_role
    self.role ||= :customer
  end
       
end

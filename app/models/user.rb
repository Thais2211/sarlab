class User < ApplicationRecord
  belongs_to :role, optional: true
  belongs_to :escola, optional: true
  has_many :schedules
  
  validates :email, uniqueness: true
  validates :nome, :celular, presence: true
  

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable
end

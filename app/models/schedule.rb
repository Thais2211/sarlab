class Schedule < ApplicationRecord
  belongs_to :equipament
  belongs_to :laboratory
  belongs_to :user
  belongs_to :typeReservation
end

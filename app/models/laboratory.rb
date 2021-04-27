class Laboratory < ApplicationRecord
  belongs_to :escola
  has_many :schedules

end

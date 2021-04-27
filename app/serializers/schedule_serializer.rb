class ScheduleSerializer < ActiveModel::Serializer
  attributes :id, :start, :end, :equipament, :laboratory, :user, :status, :created_at, :updated_at, :type_reservation

  belongs_to :equipament
  belongs_to :laboratory
  belongs_to :type_reservation

  # def color
  #   object.type_reservation.color
  # end
  

end

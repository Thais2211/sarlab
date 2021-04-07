class Schedule < ApplicationRecord
  belongs_to :equipament, optional: true
  belongs_to :laboratory
  belongs_to :user
  belongs_to :type_reservation

  def self.criarAgendamento(inicio, fim, lab, userId)
    ax = Schedule.new(start: inicio, end: fim, type_reservation_id: 1, laboratory_id: lab, user_id: userId, status: 'CONFIRMADO' )
    ax.save
  end
end

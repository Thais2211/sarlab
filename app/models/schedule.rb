class Schedule < ApplicationRecord
  include PublicActivity::Model

  belongs_to :equipament, optional: true
  belongs_to :laboratory
  belongs_to :user
  belongs_to :type_reservation

  def self.criarAgendamento(inicio, fim, lab, userId, lessonId)
    ax = Schedule.new(start: inicio, end: fim, type_reservation_id: 1, laboratory_id: lab, user_id: userId, status: 'CONFIRMADO', lesson_id: lessonId )
    ax.save
  end
end

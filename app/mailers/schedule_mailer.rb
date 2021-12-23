class ScheduleMailer < ApplicationMailer

  def new_agendamento(email)
    mail(to: email, subject: "Solicitação de reserva")
  end

  def status_reserva(email, status, motivo)
    @status = status
    @motivo = motivo

    mail(to: email, subject: "Atualização reserva lab UTFPR")
  end
end

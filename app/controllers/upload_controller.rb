class UploadController < ApplicationController
  
  def create
    if params[:equipament].present?      
      anexo = Anexo.new(equipament_id: params[:equipament])
    elsif params[:lesson_id].present?  
      anexo = Anexo.new(lesson_id: params[:lesson_id])
    end

    anexo.file = params[:file]
    
    if anexo.save!
      render json: anexo, status: 201
    else
      render json:{message: anexo.errors}, status: 500
    end
  end

  def download_file
    upload = Anexo.find params[:id]
    puts upload.file.path
    puts upload.file
    send_file upload.file.path, disposition: 'inline'
  end

  def remove_file
    upload = Anexo.find params[:id]
        
    upload.remove_file!
    
    if upload.destroy!
      if upload.lesson_id.present?
        lesson = Lesson.find upload.lesson_id
        render json: lesson
      else
        desistencia = SolicitacaoDesistencia.find upload.solicitacao_desistencia_id
        render json: desistencia
      end
    end
    
  end
    
end
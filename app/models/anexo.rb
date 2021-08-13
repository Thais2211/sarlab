class Anexo < ApplicationRecord
  belongs_to :equipament
  belongs_to :disciplina
  belongs_to :laboratory
  belongs_to :lesson

  mount_uploader :file, AnexosUploader
end

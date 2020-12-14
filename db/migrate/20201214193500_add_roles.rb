class AddRoles < ActiveRecord::Migration[5.2]
  def change
    execute <<-SQL
      INSERT INTO roles (permissao) VALUES ('ADMINISTRADOR');
      INSERT INTO roles (permissao) VALUES ('PROFESSOR');
      INSERT INTO roles (permissao) VALUES ('ALUNO');
    SQL
  end
end

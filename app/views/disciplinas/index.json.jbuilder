json.set! :data do
  json.array! @disciplinas do |disciplina|
    json.partial! 'disciplinas/disciplina', disciplina: disciplina
    json.url  "
              #{link_to 'Show', disciplina }
              #{link_to 'Edit', edit_disciplina_path(disciplina)}
              #{link_to 'Destroy', disciplina, method: :delete, data: { confirm: 'Are you sure?' }}
              "
  end
end
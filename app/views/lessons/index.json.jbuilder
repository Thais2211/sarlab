json.set! :data do
  json.array! @lessons do |lessom|
    json.partial! 'lessons/lessom', lessom: lessom
    json.url  "
              #{link_to 'Show', lessom }
              #{link_to 'Edit', edit_lessom_path(lessom)}
              #{link_to 'Destroy', lessom, method: :delete, data: { confirm: 'Are you sure?' }}
              "
  end
end
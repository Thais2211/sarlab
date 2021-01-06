json.set! :data do
  json.array! @equipaments do |equipament|
    json.partial! 'equipaments/equipament', equipament: equipament
    json.url  "
              #{link_to 'Show', equipament }
              #{link_to 'Edit', edit_equipament_path(equipament)}
              #{link_to 'Destroy', equipament, method: :delete, data: { confirm: 'Are you sure?' }}
              "
  end
end
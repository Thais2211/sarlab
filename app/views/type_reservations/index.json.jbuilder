json.set! :data do
  json.array! @type_reservations do |type_reservatiom|
    json.partial! 'type_reservations/type_reservatiom', type_reservatiom: type_reservatiom
    json.url  "
              #{link_to 'Show', type_reservatiom }
              #{link_to 'Edit', edit_type_reservatiom_path(type_reservatiom)}
              #{link_to 'Destroy', type_reservatiom, method: :delete, data: { confirm: 'Are you sure?' }}
              "
  end
end
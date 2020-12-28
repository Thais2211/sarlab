json.set! :data do
  json.array! @laboratorys do |laboratory|
    json.partial! 'laboratorys/laboratory', laboratory: laboratory
    json.url  "
              #{link_to 'Show', laboratory }
              #{link_to 'Edit', edit_laboratory_path(laboratory)}
              #{link_to 'Destroy', laboratory, method: :delete, data: { confirm: 'Are you sure?' }}
              "
  end
end
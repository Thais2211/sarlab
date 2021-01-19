json.set! :data do
  json.array! @schedules do |schedule|
    json.partial! 'schedules/schedule', schedule: schedule
    json.url  "
              #{link_to 'Show', schedule }
              #{link_to 'Edit', edit_schedule_path(schedule)}
              #{link_to 'Destroy', schedule, method: :delete, data: { confirm: 'Are you sure?' }}
              "
  end
end
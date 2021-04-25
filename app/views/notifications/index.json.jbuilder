json.array! @notifications do |notification|
    json.recipient notification.recipient
    json.actor notification.actor
    json.action notification.action
    json.notifiable notification.notifiable
    json.url ratings_path(notification.notifiable.rating, anchor: dom_id(notification.notifiable))
end


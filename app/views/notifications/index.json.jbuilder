json.array! @notifications do |notification|
    json.actor notification.actor.username
    json.action notification.action
    json.notifiable do 
        json.type "a #{notification.notifiable.class.to_s.underscore.humanize.downcase}"
    end

    json.url conversation_path(notification.notifiable.conversation, anchor: dom_id(notification.notifiable))
end
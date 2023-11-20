module SidebarHighlightHelper
  def in_feeds
    controller_name.in?('photos') && action_name.in?('index') ? 'text-primary' : 'text-secondary'
  end

  def in_my_photos
    controller_name.in?('photos') && action_name.in?('user_photos') ? 'text-primary' : 'text-secondary'
  end

  def in_my_albums
    controller_name.in?('albums') && action_name.in?('user_albums') ? 'text-primary' : 'text-secondary'
  end
end

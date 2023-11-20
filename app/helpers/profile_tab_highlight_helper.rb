module ProfileTabHighlightHelper
  def in_photos
    controller_name == 'users' && action_name == 'photos' ? 'text-primary' : 'text-secondary'
  end

  def in_albums
    controller_name == 'users' && action_name == 'albums' ? 'text-primary' : 'text-secondary'
  end

  def in_followings
    controller_name == 'users' && action_name == 'followings' ? 'text-primary' : 'text-secondary'
  end

  def in_followers
    controller_name == 'users' && action_name == 'followers' ? 'text-primary' : 'text-secondary'
  end
end

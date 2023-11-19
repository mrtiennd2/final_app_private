module UsersHelper
  def truncate_name(user)
    fst_char = user.first_name? ? user.first_name.first.upcase : ''
    snd_char = user.last_name? ? user.last_name.first.upcase : ''
    fst_char + snd_char
  end

  def full_name(user)
    fst_char = user.first_name || ' '
    snd_char = user.last_name || ' '
    "#{fst_char} #{snd_char}"
  end
end

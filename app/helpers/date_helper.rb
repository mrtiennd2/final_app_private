module DateHelper
  def format_date(date)
    date.strftime("%I:%M %p %d/%m/%Y") if date
  end
end

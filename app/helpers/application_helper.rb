module ApplicationHelper
  def fix_url(str)
    str.starts_with?("http://") ? str : "http://#{str}"
  end

  def format_date_time(dt)
    dt.strftime("%d/%m/%Y at %I:%M%p %Z")
  end
end

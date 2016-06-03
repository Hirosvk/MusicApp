module ApplicationHelper

  def auth_token
    "<input type=\"hidden\"
      name=\"authenticity_token\"
      value=\"#{form_authenticity_token}\"
      >".html_safe
  end

  def all_bands
    @all_bands ||= Band.all
  end

end

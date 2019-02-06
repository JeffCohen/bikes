module ApplicationHelper

  def show_map(lat, lng)
    url_base = 'https://maps.googleapis.com/maps/api/staticmap'
    marker = "markers=color:blue|#{lat},#{lng}"
    api_key = 'AIzaSyD-a2UU_0nTDj7XDsS82lFe2sqU9UxdY64'

    image_tag "#{url_base}?#{marker}&zoom=16&size=700x400&key=#{api_key}"
  end
end

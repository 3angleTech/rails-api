class CommonController < ApplicationController

  def health_check
    json_response(is_alive: true)
  end

  def countries
    json_response(Country.all)
  end

end

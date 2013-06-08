# This is a Sinatra convention for building helper methods. We include this file in main.rb.
helpers do
  def pre_filled_input(name, value)
    erb(
      # This helper method outputs this partial file:
      :"partials/pre_filled_input",

      # We don't want layout.erb to get applied, since this is just
      # a *partial* snippet of code.
      :layout => false,

      # The local variables in the partial file (pre_filled_input.erb) need
      # to be given values here. We're setting their values to the values of the
      # parameters passed into this pre_filled_input() method.
      :locals => {:name => name, :value => value}
    )
  end
  def back_url
    "/client_profile/" + request.fullpath
    end
end
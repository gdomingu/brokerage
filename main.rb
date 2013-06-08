require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'

ActiveRecord::Base.establish_connection(
  :adapter => 'postgresql',
  :host => 'localhost',
  :username => 'Gabriel',
  :password => '',
  :database => 'favorites',
  :encoding => 'utf8'
)

require_relative "client"
require_relative "portfolio"
require_relative "stock"
require_relative "helpers/form_helpers"

get "/" do
  @clients = Client.all
  erb :index
end

get "/new_client" do
  erb :new_client
end

#Add(save) new client to the table

post "/new_client" do
  @client = Client.new(:name => params[:client_name])
  if @client.save
    redirect "/"
  else
    erb :new_client
  end
end

#Once client is added make sure you can see the clients on the index.erb page
#Once functionality is set up to display your client name data, also set up a button to edit it.

get "/edit_client/:client_id" do
  #make sure the :client_id  is  in the url in the index.erb.
  @client = Client.find_by_id(params[:client_id])
  erb :edit_client
end

#the post will comes from filling out the forms which will update the client into.
post "/save_client/:client_id" do
  @client = Client.find_by_id(params[:client_id])

  if @client.update_attributes(:name => params[:client_name])
    #make sure to verify that :client_name is linked to the field for name
    redirect "/"
  else
    erb :edit_client
  end
end

#Start with portfolio table. Make a page where you can view portfolio on a client page(clientprofile.erb).

get "/client_profile/:client_id" do
    @stocks = Stock.all
    @client = Client.find_by_id(params[:client_id])
    erb :client_profile
end
#Create new portfolios
get "/new_portfolio" do
  erb :new_portfolio
end

#Add savenew portfolio to the tables

post "/new_portfolio" do
  @portfolio = Portfolio.new(:name => params[:portfolio_name], :client_id => params[:client_id])
  if @portfolio.save
    redirect back
  else
    erb :new_portfolio
  end
end

post "/new_portfolio/:client_id" do
  @portfolio = Portfolio.new(:name => params[:portfolio_name], :client_id => params[:client_id])
  if @portfolio.save
     redirect back
  else
    erb :new_portfolio
  end
end
##Here is where I want to be able to add a portfolio directly to the client profile
post "/edit_portfolio/:client_id" do
  @portfolio = Portfolio.new(:name => params[:portfolio_name], :client_id => params[:client_id])
  if @portfolio.save
    redirect "/edit_portfolio/:client_id"
  else
    erb :new_portfolio
  end
end


##Edit and save portfolios
get "/edit_portfolio/:portfolio_id" do
  @portfolio = Portfolio.find_by_id(params[:portfolio_id])
  erb :edit_portfolio
end

post "/save_portfolio/:portfolio_id" do
  @portfolio = Portfolio.find_by_id(params[:portfolio_id])

  if @portfolio.update_attributes(params[:portfolio])
    redirect "/"
  else
    erb :edit_portfolio
  end
end
## End edit and save portfolios
## Delete portfolio
get "/delete_portfolio/:portfolio_id" do
  @portfolio = Portfolio.find_by_id(params[:portfolio_id])
  if @portfolio.destroy
    redirect "/"
  else
    erb :index
  end
end
# Now it is time for stocks.


#Create new stocks
get "/new_stock" do
  erb :new_stock
end

#Add savenew stock to the tables

post "/new_stock" do
  @stock = Stock.new(params[:stock])
  if @stock.save
    redirect "/"
  else
    erb :new_stock
  end
end

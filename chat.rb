require 'sinatra' 
require 'sinatra/reloader' if development?
#set :port, 3000
#set :environment, :production

chat = ['Bienvenid@ al chat']
user = Array.new()

enable :sessions
set :session_secret, '*&(^#234a)'

get('/') { 
  erb :login 
}

post '/' do
  if(user.include?(params[:username]))
    redirect '/'
  else
    name = params[:username]
    session[:name] = name
    user << name
    puts user
    erb :index
  end
end

get '/logout' do
  user.delete(session[:name])
  session.clear
  redirect '/'
end

get '/send' do
  return [404, {}, "Not an ajax request"] unless request.xhr?
  chat << "#{session[:name]} : #{params['text']}"
  nil
end

get '/update' do
  return [404, {}, "Not an ajax request"] unless request.xhr?
  @updates = chat[params['last'].to_i..-1] || []

  @last = chat.size
  erb <<-'HTML', :layout => false
      <% @updates.each do |phrase| %>
        <%= phrase %> <br />
      <% end %>
      
      <span data-last="<%= @last %>"></span>
  HTML
end

get '/user' do
  return [404, {}, "Not an ajax request"] unless request.xhr?
  @user = user
  erb <<-'HTML', :layout => false
    <div id="user">
     <% @user.each do |phrase| %>
       <%= phrase %> <br />
     <% end %>
    </div>
  HTML
end

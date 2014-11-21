require 'sinatra' 
require 'sinatra/reloader' if development?
#set :port, 3000
#set :environment, :production

set :server, 'thin' 

chat = ['Bienvenid@ al chat']
user = Array.new()

get '/' do 
    erb :login
end

post '/' do
  if(user.include?(params[:username]))
    redirect '/'
  else
    name = params[:username]
    session[:name] = name
    user << name
    puts user
    erb :chat
  end
end

get '/logout' do
  user.delete(session[:name])
  session.clear
  redirect '/'
end

get '/send' do
  return [404, {}, "Not an ajax request"] unless request.xhr?
  chat << "#{session[:name]}[#{t.strftime("%d/%m/%Y %H:%M:%S")}]: #{params['text']}"
  nil
end

get '/update' do
  return [404, {}, "Not an ajax request"] unless request.xhr?
  @updates = chat[params['last'].to_i..-1] || []

  @last = chat.size
  erb <<-"HTML"
      <% @updates.each do |phrase| %>
        <%= phrase %> <br />
      <% end %>
      <span data-last="<%= @last %>"</span>
  HTML
end

get '/user' do
  return [404, {}, "Not an ajax request"] unless request.xhr?
  @user = user
  erb <<-'HTML', :layout => false
      <% @user.each do |phrase| %>
        <%= phrase %> <br />
      <% end %>
  HTML
end

get '/chat' do
  erb :chat
end

require 'sinatra' 
require 'sinatra/reloader' if development?
#set :port, 3000
#set :environment, :production

enable :sessions
set :session_secret, '*&(^#234a)'

chat = ['Bienvenid@ al chat']
@usuarios = []

get '/' do 
    erb :login
end

post '/' do
  session[:alias] = params[:username]
  @usuarios = session[:alias]
  erb :chat
end

get '/logout' do
  session.clear
  redirect '/'
end

get '/send' do
  return [404, {}, "Not an ajax request"] unless request.xhr?
  chat << "#{session[:alias]}[#{t.strftime("%d/%m/%Y %H:%M:%S")}]: #{params['text']}"
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

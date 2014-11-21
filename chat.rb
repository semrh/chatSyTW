require 'sinatra' 
require 'sinatra/reloader' if development?
require 'date'
require 'kronic'

#set :port, 3000
#set :environment, :production

set :server, 'thin'

enable :sessions
set :session_secret, '*&(^#234a)'

chat = ['Bienvenid@ al chat']
usuarios = Array.new
@listaUsuarios = []

get '/' do 
  if @listaUsuarios == nil
    @listadeUsuarios = usuarios
  end
    erb :login
end

post '/' do
  session[:alias] = params[:username]
  @usuarios = session[:alias]
  erb :chat
end

post '/registro' do
  puts "inside post '/registro/': #{params}"
  if !usuarios.include?(params[:nombre])
    session[:alias] = params[:nombre]
    usuarios.push(session[:alias])
    session[:error] = false
  else
    session[:error] = true
  end
  redirect '/'
end

get '/logout' do
  usuarios.delete_if { |a| a == session[:alias]}
  session.clear
  redirect '/'
end

get '/borrar' do
  session.clear
  usuarios.clear
  chat.clear
  @listaUsuarios = usuarios
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

get '/update/usuarios' do
  return [404, {}, "Not an ajax request"] unless request.xhr?
  @listaUsuarios = usuarios
  erb <<-"HTML"
   <% @listaUsuarios.each do |usuario| %>
     <li class="media">
       <div class="media-body">
         <div class="media">
           <a class="pull-left" href="#">
             <h3><%= usuario %> </h3>
               <small class="text-muted"><%= t = Time.now
               t.to_s
               t = t.strftime "%H:%M" + "-->" + Kronic.format(Time.now) %></small>
         </div>
       </div>
     </div>
   <hr>
   </li>
 <% end %>
 HTML
end

get '/chat' do
  erb :chat
end

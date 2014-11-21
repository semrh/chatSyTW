# -*- coding: utf-8 -*-
ENV['RACK_ENV'] = 'test'
require_relative '../chat.rb'
require_relative 'test_helper.rb'
require 'test/unit'
require 'minitest/autorun'
require 'rack/test'
require 'selenium-webdriver'
require 'rubygems'
require 'coveralls'
Coveralls.wear!

include Rack::Test::Methods

def app
   Sinatra::Application
end

describe "Tests" do
  
  it "Inicio" do
    get '/'
    expect(last_response).to be_ok
  end
  
  it "Enviar" do
    get '/send'
    expect(last_response.body).to eq("Not an ajax request")
  end
  
  it "Iniciar sesion" do
    get '/registro'
    expect(last_response).to be_ok
  end
    
  it "Cerrar sesion" do
    get '/logout'
    expect(last_response).to be_ok
  end
  
end

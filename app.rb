require "sinatra"
require "sinatra/reloader"
require "http"


# define a route
get("/") do

  # build the API url, including the API key in the query string
  api_url = "https://api.exchangerate.host/list?access_key=#{ENV["fa37e94f30043729bbef4e8a0bb21d65"]}"

  # use HTTP.get to retrieve the API information
  #get request to the URL
  raw_data = HTTP.get(api_url)
  require "json"

  # convert the raw request to a string
  raw_data_string = raw_data.to_s

  # convert the string to JSON
  parsed_data = JSON.parse(raw_data_string)

  # get the symbols from the JSON
  @symbols = parsed_data.fetch("Currency Symbols")

  # render a view template where I show the symbols
  erb(:layout)
end


get("/:from_currency") do
  @original_currency = params.fetch("from_currency")

  api_url = "https://api.exchangerate.host/list?access_key=#{ENV["fa37e94f30043729bbef4e8a0bb21d65"]}"
  
  # some more code to parse the URL and render a view template
  erb(:from)
end

get("/:from_currency/:to_currency") do
  @original_currency = params.fetch("from_currency")
  @destination_currency = params.fetch("to_currency")

  api_url = "https://api.exchangerate.host/convert?access_key=#{ENV["fa37e94f30043729bbef4e8a0bb21d65"]}&from=#{@original_currency}&to=#{@destination_currency}&amount=1"
  
  # some more code to parse the URL and render a view template
  erb(:to)
end

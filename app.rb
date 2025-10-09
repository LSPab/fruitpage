require 'sinatra'
require 'slim'
require 'sqlite3'
require 'sinatra/reloader'

#Ta bort frukt
post('/fruits/:id/delete')do
#Hämta sktuell frukt
id = params[:id].to_i
#Koppla till The Base
db = SQLite3::Database.new("db/fruits.db")

db.execute("DELETE FROM fruits WHERE id = ?",id)
redirect('/fruits')
end


get('/') do
  slim(:home)
end

get('/about') do
  slim(:about)
end

get('/death') do
  slim(:death)
end

get('/fruity/:id') do
  @fruits = ["äpple", "banan", "apelsin"]
  id = params[:id].to_i
  @fruits = fruits[id]
  slim(:fruits)
end



get('/employes') do
  @employes = [
    {"name" => "maurice",
     "age" => "like 25 ish"},
    {"name" => "monuique",
     "age" => "dead"}
  ]
  slim(:index1)
end


get('/fruits') do

  query = params[:q]


  #gör en kopplong till db
  db = SQLite3::Database.new("db/fruits.db")

  db.results_as_hash = true

  #hämta från db



  if query && !query.empty?
    @databased = db.execute("SELECT * FROM fruits WHERE name LIKE ?","%#{query}%")
  else
    @databased = db.execute("SELECT * FROM fruits")
  end

  p @databased


  #visa med slim
  slim(:"fruits/index")



end

get('/fruits/new') do
  slim(:"fruits/new")
end

get('/fruits/delete') do
  slim(:"fruits/delete")
end

post('/fruit') do

  new_fruit = params[:n]
  amount = params[:a].to_i
  db = SQLite3::Database.new("db/fruits.db")
  db.execute("INSERT INTO fruits (name, amount) VALUES (?, ?)", [new_fruit, amount])
  redirect('/fruits')
end


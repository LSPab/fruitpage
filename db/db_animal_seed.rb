require 'sqlite3'

db = SQLite3::Database.new("animals.db")

db.execute <<-SQL
  CREATE TABLE IF NOT EXISTS animals (
    id INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    amount INTEGER NOT NULL
  );
SQL

db.execute("DELETE FROM animals")  # Rensa tabellen först

animals = [
  ['Zebra',10], 
  ['Späckhuggare',20], 
  ['Struts',30], 
  ['Koi fisk',40]
]

animals.each do |animal|
  db.execute("INSERT INTO animals (name,amount) VALUES (?,?)", animal)
end

puts "Seed data inlagd."
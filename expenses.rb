require 'pg'
require './lib/company'
require './lib/category'
require './lib/expense'

DB = PG.connect({:dbname => 'expenses'})

def welcome
  puts "*" * 88
  puts "\t\t\tEXPENSE TRACKER"
  puts "*" * 88
end

welcome

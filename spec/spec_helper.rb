require 'pg'
require 'rspec'
require 'category'
require 'company'
require 'expense'

DB = PG.connect({:dbname => 'expenses_test'})

RSpec.configure do |config|
  config.before(:each) do
    DB.exec("DELETE FROM expenses *;")
    DB.exec("DELETE FROM companies *;")
    DB.exec("DELETE FROM expenses_categories *;")
    DB.exec("DELETE FROM categories *;")
  end
end

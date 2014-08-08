require 'pg'
require './lib/company'
require './lib/category'
require './lib/expense'

DB = PG.connect({:dbname => 'expenses'})

def header
  system('clear')
  puts "*" * 88
  puts "\t\t\tEXPENSE TRACKER"
  puts "*" * 88
end

def main_menu
  header
  puts "1) Expenses"
  puts "2) Companies"
  puts "3) Categories"
  puts "4) Reports"
  puts "5) Exit"
  puts "Enter an option"
  case gets.chomp.to_i
  when 1
    expenses_menu
  when 2
    companies_menu
  when 3

  when 4

  when 5
    exit
  else
    puts "Enter a valid number"
  end
  main_menu
end

def expenses_menu
  header
  puts "1) Enter a new expense"
  puts "2) Edit an expense"
  puts "3) View all expenses"
  puts "4) Remove an expense"
  puts "5) Search for an expense"
  puts "Enter an option"
  case gets.chomp.to_i
  when 1
    new_expense
  when 2
    edit_expense
  when 3
    view_expenses
  when 4

  when 5
    exit
  else
    puts "Enter a valid number"
  end
  main_menu
end

def new_expense
  view_companies
  puts "Company Id or enter 'n' to enter a new company?"
  new_company_id = gets.chomp.to_i
  new_company if new_company_id == 0
  new_expense if new_company_id == 0
  puts "Enter a description for this expense:"
  new_description = gets.chomp.upcase
  puts "Amount?"
  new_amount = gets.chomp.to_f
  puts "Date?"
  new_date = gets.chomp
  Expense.new({'description' => new_description, 'amount' => new_amount, 'date' => new_date, 'company_id' => new_company_id}).save
  expenses_menu
end

def view_expenses
  header
  Expense.all.each do |expense|
    puts expense.id.to_s + ") " + expense.description.to_s + "(" + expense.date + ") - $" + expense.amount.to_s
  end
  puts "what do you think about this?"
  gets.chomp
end

def edit_expense
end

def companies_menu
  puts "1) Enter a new company"
  puts "2) Edit a company"
  puts "3) View all companies"
  puts "4) Remove a company"
  puts "5) Return to Main Menu"
  puts "Enter an option"
  case gets.chomp.to_i
  when 1
    new_company
  when 2
    edit_company
  when 3
    view_companies
  when 4
    remove_company
  when 5
    main_menu
  else
    puts "Enter a valid number"
  end
  companies_menu
end

def new_company
  puts "Enter the name of the company"
  Company.new({'name' => gets.chomp.upcase}).save
end

def view_companies
  companies = Company.all
  puts "Companies:"
  companies.each do |company|
    puts company.id.to_s + ") Name: " + company.name.to_s
  end
end

def edit_company
  view_companies
  puts "Enter the company number to edit:"
  current_company = Company.find(gets.chomp.to_i)
  puts "New name?"
  current_company.edit_name(gets.chomp.upcase)
  puts "saved"
end

def remove_company
  view_companies
  puts "Enter the company number to delete:"
  current_company = Company.find(gets.chomp.to_i)
  current_company.delete
  puts "deleted"
end

main_menu

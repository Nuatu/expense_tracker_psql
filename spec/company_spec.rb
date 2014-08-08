require 'spec_helper'

describe "Company" do
  describe "initialize" do
    it "initializes a company with a hash" do
      test_company = Company.new(ATTRIBUTES)
      expect(test_company).to be_a Company
      expect(test_company.name).to eq "house"
    end
  end

  describe "save" do
    it "saves an company in the database" do
      test_company = Company.new(ATTRIBUTES)
      test_company.save
      expect(Company.all).to eq [test_company]
    end
  end

  describe ".all" do
    it "returns all categories" do
      test_company = Company.new(ATTRIBUTES)
      test_company.save
      expect(Company.all).to eq [test_company]
    end
  end

  describe "==" do
    it "sets two objects as equal if their values are equal" do
      test_company = Company.new(ATTRIBUTES)
      test_company.save
      test_company1 = Company.new(ATTRIBUTES)
      test_company1.save
      expect(test_company).to eq test_company1
    end
  end

  describe "edit_name" do
    it "change company name" do
      test_company = Company.new(ATTRIBUTES)
      test_company.save
      test_company.edit_name("home")
      expect(test_company.name).to eq "home"
    end
  end

  describe "delete" do
    it "deletes an company from the database" do
      test_company = Company.new(ATTRIBUTES)
      test_company.save
      test_company.delete
      expect(Company.all).to eq []
    end
  end

  describe "total" do
    it "sums the expenses associated with a company" do
      test_company = Company.new(ATTRIBUTES)
      test_company.save
      id = test_company.id
      test_expense = Expense.new({'description' => "lunch", 'amount' => 7.43, 'date' => "2014-08-07", 'company_id' => id})
      test_expense.save
      test_expense1 = Expense.new({'description' => "dinner", 'amount' => 10.00, 'date' => "2014-08-08", 'company_id' => id})
      test_expense1.save
      expect(test_company.total).to eq 17.43
    end
  end

   describe "percent_of_total" do
    it "returns the percentage spent at a company" do
      test_company = Company.new(ATTRIBUTES)
      test_company.save
      id = test_company.id
      test_company1 = Company.new({'name' => 'work'})
      test_company1.save
      id1 = test_company1.id
      test_expense = Expense.new({'description' => 'breakfast', 'amount' => 4.50, 'date' => '2014-07-27', 'company_id' => id})
      test_expense.save
      test_expense1 = Expense.new({'description' => 'lunch', 'amount' => 4.50, 'date' => '2014-07-27', 'company_id' => id1})
      test_expense1.save
      expect(test_company.percent_of_total).to eq 50
    end
  end
end

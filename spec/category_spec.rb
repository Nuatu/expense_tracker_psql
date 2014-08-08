require 'spec_helper'

describe "Category" do
  describe "initialize" do
    it "initializes an category with a hash" do
      test_category = Category.new(ATTRIBUTES)
      expect(test_category).to be_a Category
      expect(test_category.budget).to eq 300.00
      expect(test_category.name).to eq "house"
    end
  end

  describe "save" do
    it "saves an category in the database" do
      test_category = Category.new(ATTRIBUTES)
      test_category.save
      expect(Category.all).to eq [test_category]
    end
  end

  describe ".all" do
    it "returns all categories" do
      test_category = Category.new(ATTRIBUTES)
      test_category.save
      expect(Category.all).to eq [test_category]
    end
  end

  describe "==" do
    it "sets two objects as equal if their values are equal" do
      test_category = Category.new(ATTRIBUTES)
      test_category.save
      test_category1 = Category.new(ATTRIBUTES)
      test_category1.save
      expect(test_category).to eq test_category1
    end
  end

  describe "edit_description, amount, date, company_id" do
    it "changes the description of an category, amount, date, and company_id" do
      test_category = Category.new(ATTRIBUTES)
      test_category.save
      test_category.edit_name("home")
      test_category.edit_budget(400.00)
      expect(test_category.name).to eq "home"
      expect(test_category.budget).to eq 400.00
    end
  end

  describe "delete" do
    it "deletes an category from the database" do
      test_category = Category.new(ATTRIBUTES)
      test_category.save
      test_category.delete
      expect(Category.all).to eq []
    end
  end

  describe "total" do
    it "adds the total expenses for that category" do
      test_category = Category.new(ATTRIBUTES)
      test_category.save
      id = test_category.id
      test_expense = Expense.new(ATTRIBUTES)
      test_expense.save
      test_expense.add_category(id)
      test_expense1 = Expense.new({'description' => 'breakfast', 'amount' => 4.50, 'date' => '2014-07-27', 'company_id' => '3'})
      test_expense1.save
      test_expense1.add_category(id)
      expect(test_category.total).to eq 11.93
    end
  end

  describe "total_month" do
    it "adds the total expenses for that category" do
      test_category = Category.new(ATTRIBUTES)
      test_category.save
      id = test_category.id
      test_expense = Expense.new(ATTRIBUTES)
      test_expense.save
      test_expense.add_category(id)
      test_expense1 = Expense.new({'description' => 'breakfast', 'amount' => 4.50, 'date' => '2014-07-27', 'company_id' => '3'})
      test_expense1.save
      test_expense1.add_category(id)
      expect(test_category.total_month(8,2014)).to eq 7.43
    end
  end

   describe ".total" do
    it "adds the total across all categories" do
      test_category = Category.new(ATTRIBUTES)
      test_category.save
      id = test_category.id
      test_category1 = Category.new({'name' => 'work'})
      test_category1.save
      id1 = test_category1.id
      test_expense = Expense.new(ATTRIBUTES)
      test_expense.save
      test_expense.add_category(id)
      test_expense1 = Expense.new({'description' => 'breakfast', 'amount' => 4.50, 'date' => '2014-07-27', 'company_id' => '3'})
      test_expense1.save
      test_expense1.add_category(id1)
      expect(Category.total).to eq 11.93
    end
  end

  describe "percent_of_total" do
    it "returns the percentage spent on a category" do
      test_category = Category.new(ATTRIBUTES)
      test_category.save
      id = test_category.id
      test_category1 = Category.new({'name' => 'work'})
      test_category1.save
      id1 = test_category1.id
      test_expense = Expense.new(ATTRIBUTES)
      test_expense.save
      test_expense.add_category(id)
      test_expense1 = Expense.new({'description' => 'breakfast', 'amount' => 4.50, 'date' => '2014-07-27', 'company_id' => '3'})
      test_expense1.save
      test_expense1.add_category(id1)
      expect(test_category.percent_of_total).to eq 62
    end
  end

  describe "amount_to_spend" do
    it "returns the amount left to spend that month in that category" do
      test_category = Category.new(ATTRIBUTES)
      test_category.save
      id = test_category.id
      test_expense = Expense.new(ATTRIBUTES)
      test_expense.save
      test_expense.add_category(id)
      expect(test_category.amount_to_spend(8,2014)).to eq 292.57
      test_expense1 = Expense.new('amount' => 400.00, 'date' => '2014-08-27')
      test_expense1.save
      test_expense1.add_category(id)
      expect(test_category.amount_to_spend(8,2014)).to eq -107.43
    end
  end
end

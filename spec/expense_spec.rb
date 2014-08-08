require 'spec_helper'

describe "Expense" do
  describe "initialize" do
    it "initializes an expense with a hash" do
      test_expense = Expense.new(ATTRIBUTES)
      expect(test_expense).to be_a Expense
      expect(test_expense.amount).to eq 7.43
      expect(test_expense.date).to eq "2014-08-07"
    end
  end

  describe "save" do
    it "saves an expense in the database" do
      test_expense = Expense.new(ATTRIBUTES)
      test_expense.save
      expect(Expense.all).to eq [test_expense]
    end
  end

  describe ".all" do
    it "returns all expenses" do
      test_expense = Expense.new(ATTRIBUTES)
      test_expense.save
      expect(Expense.all).to eq [test_expense]
    end
  end

  describe "==" do
    it "sets two objects as equal if their values are equal" do
      test_expense = Expense.new(ATTRIBUTES)
      test_expense.save
      test_expense1 = Expense.new(ATTRIBUTES)
      test_expense1.save
      expect(test_expense).to eq test_expense1
    end
  end

  describe "edit_description, amount, date, company_id" do
    it "changes the description of an expense, amount, date, and company_id" do
      test_expense = Expense.new(ATTRIBUTES)
      test_expense.save
      test_expense.edit_description("afternoon snack")
      test_expense.edit_amount(8.50)
      test_expense.edit_date("2015-01-03")
      test_expense.edit_company_id(3)
      expect(test_expense.description).to eq "afternoon snack"
      expect(test_expense.amount).to eq 8.50
      expect(test_expense.date).to eq "2015-01-03"
      expect(test_expense.company_id).to eq 3
    end
  end

  describe "delete" do
    it "deletes an expense from the database" do
      test_expense = Expense.new(ATTRIBUTES)
      test_expense.save
      test_expense.delete
      expect(Expense.all).to eq []
    end
  end

  describe "add_category" do
    it "adds a category to an expense" do
      test_expense = Expense.new(ATTRIBUTES)
      test_expense.save
      test_category = Category.new(ATTRIBUTES)
      test_category.save
      id = test_category.id
      test_expense.add_category(id)
      expect(test_expense.categories).to eq [test_category]
    end
  end

  describe "categories" do
    it "displays all the categories associated with an expense" do
      test_expense = Expense.new(ATTRIBUTES)
      test_expense.save
      test_category = Category.new(ATTRIBUTES)
      test_category.save
      id = test_category.id
      test_category1 = Category.new({'name' => 'school', 'budget' => 100.00})
      test_category1.save
      id1 = test_category1.id
      test_expense.add_category(id)
      test_expense.add_category(id1)
      expect(test_expense.categories).to eq [test_category, test_category1]
    end
  end
end

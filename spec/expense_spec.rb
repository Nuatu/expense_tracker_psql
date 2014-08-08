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

end

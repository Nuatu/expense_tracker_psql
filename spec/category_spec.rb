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
end

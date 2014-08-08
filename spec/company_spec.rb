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
end

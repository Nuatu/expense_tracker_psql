class Expense
  attr_accessor :description, :amount, :date, :company_id
  attr_reader :id

  def initialize(attributes)
    @id = attributes['id'].to_i
    @description = attributes['description']
    @amount = attributes['amount'].to_f
    @date = attributes['date']
    @company_id = attributes['company_id'].to_i
  end

  def self.all
    output = []
    results = DB.exec("SELECT * FROM expenses;")
    results.each do |result|
      output << Expense.new(result)
    end
    output
  end

  def save
    result = DB.exec("INSERT INTO expenses (description, amount, date) VALUES ('#{@description}', #{@amount}, '#{@date}') RETURNING id;")
    @id = result.first['id'].to_i
  end

  def ==(other_expense)
    @description == other_expense.description && @amount == other_expense.amount && @date == other_expense.date && @company_id == other_expense.company_id
  end

  def edit_description(new_description)
    DB.exec("UPDATE expenses SET description = '#{new_description}' WHERE id = #{@id};")
    @description = new_description
  end

  def edit_amount(new_amount)
    DB.exec("UPDATE expenses SET amount = #{new_amount} WHERE id = #{@id};")
    @amount = new_amount
  end

  def edit_date(new_date)
    DB.exec("UPDATE expenses SET date = '#{new_date}' WHERE id = #{@id};")
    @date = new_date
  end

  def edit_company_id(new_company_id)
    DB.exec("UPDATE expenses SET company_id = #{new_company_id} WHERE id = #{@id};")
    @company_id = new_company_id
  end

  def delete
    DB.exec("DELETE FROM expenses WHERE id = #{@id};")
  end

  def add_category(id)
    DB.exec("INSERT INTO expenses_categories (expense_id, category_id) VALUES (#{@id}, #{id});")
  end

  def categories
    output = []
    results = DB.exec("SELECT categories.* FROM expenses JOIN expenses_categories ON (expenses.id = expenses_categories.expense_id) JOIN categories ON (expenses_categories.category_id = categories.id) WHERE expenses.id = #{@id};")
    results.each do |result|
      output << Category.new(result)
    end
    output
  end
end

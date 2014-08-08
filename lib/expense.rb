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
      p result
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
end

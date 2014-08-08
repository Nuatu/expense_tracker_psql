class Company
  attr_accessor :name
  attr_reader :id

  def initialize(attributes)
    @id = attributes['id'].to_i
    @name = attributes['name']
  end

  def self.all
    output = []
    results = DB.exec("SELECT * FROM companies;")
    results.each do |result|
      output << Company.new(result)
    end
    output
  end

  def self.find(id)
    results = DB.exec("SELECT * FROM companies WHERE id = #{id};").first
    Company.new(results)
  end

  def save
    result = DB.exec("INSERT INTO companies (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first['id'].to_i
  end

  def ==(other_category)
    @name == other_category.name
  end

  def edit_name(new_name)
    DB.exec("UPDATE companies SET name = '#{new_name}' WHERE id = #{@id};")
    @name = new_name
  end

  def delete
    DB.exec("DELETE FROM companies WHERE id = #{@id};")
  end

  def total
    DB.exec("SELECT SUM (amount) FROM companies JOIN expenses ON (companies.id = expenses.company_id) WHERE #{@id} = expenses.company_id;").first['sum'].to_f
  end

  def percent_of_total
    (self.total / Expense.total * 100).to_i
  end
end

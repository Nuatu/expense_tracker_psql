class Category
  attr_accessor :name, :budget
  attr_reader :id

  def initialize(attributes)
    @id = attributes['id'].to_i
    @name = attributes['name']
    @budget = attributes['budget'].to_f
  end

  def self.all
    output = []
    results = DB.exec("SELECT * FROM categories;")
    results.each do |result|
      output << Category.new(result)
    end
    output
  end

  def save
    result = DB.exec("INSERT INTO categories (name, budget) VALUES ('#{@name}', #{@budget}) RETURNING id;")
    @id = result.first['id'].to_i
  end

  def ==(other_category)
    @name == other_category.name && @budget == other_category.budget
  end

  def edit_name(new_name)
    DB.exec("UPDATE categories SET name = '#{new_name}' WHERE id = #{@id};")
    @name = new_name
  end

  def edit_budget(new_budget)
    DB.exec("UPDATE categories SET budget = #{new_budget} WHERE id = #{@id};")
    @budget = new_budget
  end

  def delete
    DB.exec("DELETE FROM categories WHERE id = #{@id};")
  end

end

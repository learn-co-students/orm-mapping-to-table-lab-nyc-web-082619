class Student
  attr_accessor :name, :grade
  attr_reader :id

  def initialize(name, grade, id = nil)
    @name = name
    @grade = grade
    @id = id
  end

  def save
    sql = "INSERT INTO students(name, grade) VALUES (?,?)"
    DB[:conn].execute(sql, name, grade)
    sql = "SELECT last_insert_rowid() FROM students"
    @id = DB[:conn].execute(sql)[0][0]
    self
  end

  def self.create(attributes)
    student = new(attributes[:name], attributes[:grade])
    student.save
  end

  def self.create_table
    sql = "CREATE TABLE IF NOT EXISTS students(id INTEGER PRIMARY KEY, name TEXT, grade INT);"
    DB[:conn].execute(sql)
  end

  def self.drop_table
    DB[:conn].execute("DROP TABLE students")
  end
  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]

end

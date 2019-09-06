class Student

    attr_reader :id
    attr_accessor :name, :grade

    def initialize (name, grade, id=nil)
      @id = id
      @name = name
      @grade = grade
    end

    def self.create_table
      meat = <<-SpaghettiAndMeatballs
        CREATE TABLE IF NOT EXISTS students (
          id INTEGER PRIMARY KEY,
          name TEXT,
          grade INTEGER
        )
        SpaghettiAndMeatballs
        DB[:conn].execute(meat)
    end

    def
      self.drop_table
      sql = "DROP TABLE students"
      DB[:conn].execute(sql)
    end

    def save
      sql = "
        INSERT INTO students (name, grade)
          VALUES (?, ?)
      "
  
      DB[:conn].execute(sql, self.name, self.grade)

      @id = DB[:conn].execute("SELECT last_insert_rowid() FROM students")[0][0]
    end

    def self.create(name:, grade:)
      student = Student.new(name, grade)
      student.save
      student
    end

      
  
end

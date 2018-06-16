require_relative "../config/environment.rb"

class Student
  
  attr_accessor :id, :name, :grade


  def initialize(id: nil, name:, grade:)
  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]
  end
  
  
  def self.create_table
    sql = <<-SQL
    CREATE TABLE IF NOT EXISTS students (
    id INTEGER PRIMARY KEY,
    name TEXT,
    grade INTEGER
    )
    SQL

    DB[:conn].execute(sql)
  end
  
  
  def self.drop_table
    sql = "DROP TABLE IF EXISTS students"
    DB[:conn].execute(sql)
  end
  
  
  
  
  
  
  
  def save
    sql = <<-SQL
      INSERT INTO students (name, grade)
      VALUES (?, ?)
    SQL

    DB[:conn].execute(sql, self.name, self.grade)
  end
  
def save
  if self.id
    self.update
  else
    sql = <<-SQL
      INSERT INTO songs (name, album) 
      VALUES (?, ?)
    SQL
    DB[:conn].execute(sql, self.name, self.album)
    @id = DB[:conn].execute("SELECT last_insert_rowid() FROM songs")[0][0]
  end 
end  
  
  
  
  
  
  
  
  
  def self.create(name:, album:)
    song = Song.new(name, album)
    song.save
    song
  end
  
  
  def self.new_from_db(row)
    new_student = Student.new
    new_student.id = row[0]
    new_student.name = row[1]
    new_student.grade = row[2]
    new_student.save
    new_student
  end
  
  
   def self.find_by_name(name)
    sql = <<-SQL
      SELECT *
      FROM students
      WHERE name = ?
    SQL

    DB[:conn].execute(sql, name).map do |row| 
      self.new_from_db(row)
    end.first
  end


end

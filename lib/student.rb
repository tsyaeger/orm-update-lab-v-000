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
  
  


end

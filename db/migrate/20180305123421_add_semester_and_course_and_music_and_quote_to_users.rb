class AddSemesterAndCourseAndMusicAndQuoteToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :semester, :integer
    add_column :users, :course, :string
    add_column :users, :music, :string
    add_column :users, :quote, :string
  end
end

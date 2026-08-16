class AddUniqueIndexToCourseName < ActiveRecord::Migration[8.0]
  def change
    add_index :courses,
              "LOWER(name)",
              unique: true,
              name: "index_courses_on_lower_name"
  end
end
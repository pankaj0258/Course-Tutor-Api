class AddUniqueIndexToTutorsEmail < ActiveRecord::Migration[8.0]
  def change
    add_index :tutors,
              "LOWER(email)",
              unique: true,
              name: "index_tutors_on_lower_email"
  end
end

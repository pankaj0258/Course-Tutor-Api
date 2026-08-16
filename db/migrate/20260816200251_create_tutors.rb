class CreateTutors < ActiveRecord::Migration[8.0]
  def change
    create_table :tutors do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.integer :experience_years, null: false
      t.references :course, null: false, foreign_key: true

      t.timestamps
    end
  end
end

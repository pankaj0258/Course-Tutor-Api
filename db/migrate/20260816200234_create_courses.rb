class CreateCourses < ActiveRecord::Migration[8.0]
  def change
    create_table :courses do |t|
      t.string :name, null: false
      t.text :description, null: false
      t.integer :status, null: false

      t.timestamps
    end
  end
end

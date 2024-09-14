class CreateComment2s < ActiveRecord::Migration[7.1]
  def change
    create_table :comment2s do |t|
      t.text :content
      t.references :movie, null: false, foreign_key: true
      t.references :reviewer, null: false, foreign_key: true

      t.timestamps
    end
  end
end

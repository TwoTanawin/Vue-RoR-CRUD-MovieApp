class CreateReviewers < ActiveRecord::Migration[7.1]
  def change
    create_table :reviewers do |t|
      t.string :name
      t.string :email

      t.timestamps
    end
  end
end

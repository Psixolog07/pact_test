class CreateUserInterest < ActiveRecord::Migration[6.0]
  def change
    create_table :user_interests do |t|
      t.integer :user_id, null: false, index: true
      t.integer :interest_id, null: false, index: true

      t.timestamps
    end
  end
end

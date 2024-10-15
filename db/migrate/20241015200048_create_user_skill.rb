class CreateUserSkill < ActiveRecord::Migration[6.0]
  def change
    # Аналогичное относится и к связям внутри бд. Лучше не уровне апа их делать.

    create_table :user_skills do |t|
      t.integer :user_id, null: false, index: true
      t.integer :skill_id, null: false, index: true

      t.timestamps
    end
  end
end

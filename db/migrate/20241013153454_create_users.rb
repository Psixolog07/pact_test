class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    # Хоть из модели и понятно, что некоторые параметры обязательные, на уровне бд не стоит те же правила накладывать.
    # (За исключением 100% случаев)
    # Потом изменения хотелок придется и на уровне бд менять, что может лишних проблем создать.

    create_table :users do |t|
      t.string :name
      t.string :surname
      t.string :patronymic
      t.string :full_name
      t.string :email, uniq: true, index: true
      t.string :nationality
      t.string :country
      t.string :gender
      t.integer :age

      t.timestamps
    end
  end
end

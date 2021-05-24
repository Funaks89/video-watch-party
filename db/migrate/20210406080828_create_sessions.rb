class CreateSessions < ActiveRecord::Migration[6.1]
  add_index :users, :username, unique: true
  def change
    create_table :sessions do |t|
      t.string :username, null: false
      t.boolean :expired, default: false

      t.timestamps
    end
  end
end

class AddSessionsTable < ActiveRecord::Migration[8.0]
  def change
    create_table :sessions do |t|
      t.string :session_id, null: false
      t.bigint :user_id, index: true
      t.string :ip_address
      t.text :user_agent
      t.text :data
      t.timestamps
    end

    add_index :sessions, :session_id, unique: true
    add_index :sessions, :updated_at
  end
end

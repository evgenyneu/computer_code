class AddWordToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :word, :string, null: false
  end
end

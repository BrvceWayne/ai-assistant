class CreateCharacters < ActiveRecord::Migration[7.1]
  def change
    create_table :characters do |t|
      t.string :name
      t.string :class_type
      t.integer :health
      t.string :quirks
      t.integer :mana
      t.integer :strength

      t.timestamps
    end
  end
end

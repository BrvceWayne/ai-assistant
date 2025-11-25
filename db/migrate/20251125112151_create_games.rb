class CreateGames < ActiveRecord::Migration[7.1]
  def change
    create_table :games do |t|
      t.references :user, null: false, foreign_key: true
      t.references :character, null: false, foreign_key: true
      t.references :scenario, null: false, foreign_key: true
      t.string :state

      t.timestamps
    end
  end
end

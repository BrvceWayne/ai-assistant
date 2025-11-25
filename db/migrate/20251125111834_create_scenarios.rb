class CreateScenarios < ActiveRecord::Migration[7.1]
  def change
    create_table :scenarios do |t|
      t.string :title
      t.string :description
      t.string :scenario_prompt

      t.timestamps
    end
  end
end

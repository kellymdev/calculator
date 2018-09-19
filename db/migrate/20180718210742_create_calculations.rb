class CreateCalculations < ActiveRecord::Migration[5.2]
  def change
    create_table :calculations do |t|
      t.string :equation
      t.decimal :answer
      t.belongs_to :basic_calculator
      t.timestamps
    end
  end
end

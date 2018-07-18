class CreateBasicCalculators < ActiveRecord::Migration[5.2]
  def change
    create_table :basic_calculators do |t|
      t.decimal :memory
      t.timestamps
    end
  end
end

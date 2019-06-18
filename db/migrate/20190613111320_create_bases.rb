class CreateBases < ActiveRecord::Migration[5.1]
  def change
    create_table :bases do |t|
      t.string :name
      t.string :number
      t.string :atype

      t.timestamps
    end
  end
end

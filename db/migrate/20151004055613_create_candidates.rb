class CreateCandidates < ActiveRecord::Migration
  def change
    create_table :candidates do |t|
      t.string :name
      t.string :donor
      t.string :total

      t.timestamps null: false
    end
  end
end

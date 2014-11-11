class CreatePasties < ActiveRecord::Migration
  def change
    create_table :pasties do |t|
      t.string :token
      t.text :content

      t.timestamps
    end
  end
end

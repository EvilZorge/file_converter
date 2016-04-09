class CreateExtensions < ActiveRecord::Migration
  def change
    create_table :extensions do |t|
      t.string :name, null: false
      t.references :format, null: false
      t.timestamps null: false
    end

    add_index :extensions, :format_id
  end
end

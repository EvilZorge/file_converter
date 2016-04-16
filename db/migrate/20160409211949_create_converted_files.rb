class CreateConvertedFiles < ActiveRecord::Migration
  def change
    create_table :converted_files do |t|
      t.string :file, null: false
      t.string :state, null: false, default: 'uploaded'
      t.references :user
      t.references :extension
      t.timestamps null: false
    end

    add_index :converted_files, :user_id
  end
end

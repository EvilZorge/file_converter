class CreateConvertedFiles < ActiveRecord::Migration
  def change
    create_table :converted_files do |t|
      t.string :file, null: false
      t.string :state, null: false, default: 'uploaded'
      t.references :user
      t.timestamps null: false
    end
  end
end

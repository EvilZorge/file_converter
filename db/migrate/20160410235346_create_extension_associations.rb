class CreateExtensionAssociations < ActiveRecord::Migration
  def change
    create_table :extension_associations do |t|
      t.integer :extension_id, null: false
      t.integer :converted_extension_id, null: false
    end

    add_index :extension_associations, :extension_id
    add_index :extension_associations, :converted_extension_id
  end
end

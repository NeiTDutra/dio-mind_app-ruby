class CreateTags < ActiveRecord::Migration[6.0]
  def change
    create_table :tags do |t|
      # This extension is for postgresql
      # enable_extension('citext')
      # t.citext :name
      t.string :name
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end

    add_index :tags, [:name, :user_id], unique: true
  end
end

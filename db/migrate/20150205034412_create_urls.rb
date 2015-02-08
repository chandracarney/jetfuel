class CreateUrls < ActiveRecord::Migration
  def change
    create_table :urls do |t|
      t.string :original_url, null: false, default: ""
      t.string :slug
      t.string :title
      t.integer :popularity, default: 0

      t.timestamps null: false
    end
  end
end

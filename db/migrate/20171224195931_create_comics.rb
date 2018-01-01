class CreateComics < ActiveRecord::Migration[5.1]
  def change
    create_table :comics do |t|
      t.string :title
      t.string :path
      t.string :alt
      t.integer :tag_id

      t.timestamps
    end
  end
end

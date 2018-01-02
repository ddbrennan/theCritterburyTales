class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.boolean :like
      t.string :content
      t.belongs_to :comic, foreign_key: true
    end
  end
end

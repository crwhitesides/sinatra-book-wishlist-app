class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :title
      t.string :author
      t.belongs_to :user, index: true
      t.timestamps
    end
  end
end

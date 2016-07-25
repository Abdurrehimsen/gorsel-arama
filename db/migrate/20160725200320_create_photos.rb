class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.integer :docid
      t.string :url

      t.timestamps
    end
  end
end

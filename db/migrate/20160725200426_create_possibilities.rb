class CreatePossibilities < ActiveRecord::Migration
  def change
    create_table :possibilities do |t|
      t.float :poss
      t.belongs_to :tag, index: true
      t.belongs_to :photo, index: true

      t.timestamps
    end
  end
end

class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.integer :value, null: false
      t.integer :votable_id, null: false
      t.string :votable_type, null: false
      t.integer :voter_id, null: false, index: true

      t.timestamps null: false
    end
    add_index :votes, [:votable_id, :votable_type, :voter_id], unique: true
  end
end

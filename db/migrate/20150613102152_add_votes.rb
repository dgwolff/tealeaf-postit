class AddVotes < ActiveRecord::Migration
  create_table :votes do |t|
    t.boolean :vote
    t.integer :user_id
    t.string :voteable_type
    t.integer :voteable_id

    t.timestamps
  end
end

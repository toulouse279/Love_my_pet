class CreateSubscriptions < ActiveRecord::Migration[5.2]
  def change
    create_join_table :pets, :users, table_name: 'subscriptions' do |t|
      t.index [:pet_id, :user_id]
      t.index [:user_id, :pet_id]
    end
  end
end

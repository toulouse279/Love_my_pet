class CreateJoinTablePetPost < ActiveRecord::Migration[5.2]
  def change
    create_join_table :pets, :posts do |t|
      t.index [:pet_id, :post_id]
      t.index [:post_id, :pet_id]
    end
  end
end

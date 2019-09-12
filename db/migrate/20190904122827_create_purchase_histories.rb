class CreatePurchaseHistories < ActiveRecord::Migration[5.2]
  def change
    create_table :purchase_histories do |t|
      t.references :user, index: true, null: false, foreign_key: true
      t.references :product, index: true, null: false, foreign_key: true
      t.timestamps
    end
  end
end

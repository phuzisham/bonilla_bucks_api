class CreateWithdrawls < ActiveRecord::Migration[5.1]
  def change
    create_table :withdrawls do |t|
      t.string :notes
      t.integer :amount
      t.references :account, foreign_key: true

      t.timestamps
    end
  end
end

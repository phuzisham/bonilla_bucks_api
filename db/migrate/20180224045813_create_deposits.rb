class CreateDeposits < ActiveRecord::Migration[5.1]
  def change
    create_table :deposits do |t|
      t.string :notes
      t.integer :amount
      t.references :account, foreign_key: true

      t.timestamps
    end
  end
end

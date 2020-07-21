class CreateActivities < ActiveRecord::Migration[5.2]
  def change
    create_table :activities do |t|
      t.datetime :date_start
      t.datetime :date_end
      t.references :user, foreign_key: true
      t.references :activity_type, foreign_key: true
      t.integer :payment_type
      t.integer :cost
      t.string :short_description
      t.text :description
      t.integer :age_limit

      t.timestamps
    end
  end
end

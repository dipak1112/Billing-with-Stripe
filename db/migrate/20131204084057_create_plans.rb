class CreatePlans < ActiveRecord::Migration
  def change
    create_table :plans do |t|
      t.string 	 :name
      t.integer  :price
      t.string 	 :plan_code
      t.timestamps
    end
  end
end

class CreateActivities < ActiveRecord::Migration[5.1]
  def change
    create_table :activities do |t|
      t.string :name
      t.string :schedule
      t.string :url_img

      t.timestamps
    end
  end
end

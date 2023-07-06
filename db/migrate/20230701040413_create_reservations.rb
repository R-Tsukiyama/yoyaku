class CreateReservations < ActiveRecord::Migration[6.1]
  def change
    create_table :reservations do |t|
      t.date :checkin_date
      t.date :checkout_date
      t.integer :person_count
      t.string :user_id
      t.string :room_id

      t.timestamps
    end
  end
end

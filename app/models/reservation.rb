class Reservation < ApplicationRecord
    belongs_to :user
    belongs_to :room
    validates :checkin_date, :checkout_date, :person_count, presence: true
    validates :start_end_check
   #チェックイン/アウトのバリデーション
    def start_end_check
      if checkin_date == nil
        errors.add(:checkin_date, "開始日を入力してください")
      elsif checkout_date == nil
        errors.add(:checkout_date, "終了日を入力してください")
      elsif checkout_date < checkin_date
        errors.add(:checkout_date, "終了日は開始日よりも後の日付にしてください")
      end
    end

    def total_date
        duration = (checkout_date - checkin_date).to_i
    end

    def total_price
        total_price = (total_date * person_count * room.price)
    end
end

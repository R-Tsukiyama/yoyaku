class Reservation < ApplicationRecord
    belongs_to :user
    belongs_to :room
    
    validates :checkin_date, presence: { message: "日を入力してください" }
    validates :checkout_date, presence: { message: "日を入力してください" }
    validates :person_count, presence: { message: "を入力してください。" } , numericality: {only_integer: true, greater_than: 1}

    validate :start_end_check
   #チェックイン/アウトのバリデーション
    def start_end_check
      if checkin_date.nil? || checkout_date.nil?
        return
      end
      if self.checkout_date < self.checkin_date
        errors.add(:checkout_date, "は開始日より前の日付は登録できません。") 
      end
    end

    def total_date
        duration = (checkout_date - checkin_date).to_i
    end

    def total_price
        total_price = (total_date * person_count * room.price)
    end

    
end

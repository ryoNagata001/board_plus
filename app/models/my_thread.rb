class MyThread < ApplicationRecord
    has_many :comments, dependent: :destroy
    validates :title, presence: { message: "スレッド名を入力してください"}
end

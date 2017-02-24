class Comment < ApplicationRecord
  belongs_to :my_thread
  validates :name, presence: { message: "入力してください"} 
  validates :content, presence: { message: "入力してください"} 
end

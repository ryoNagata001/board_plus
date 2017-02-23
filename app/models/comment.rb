class Comment < ApplicationRecord
  belongs_to :my_thread
  validates :name, presence: { message: "名前を入力してください"} 
  validates :content, presence: { message: "コメントを入力してください"} 
end

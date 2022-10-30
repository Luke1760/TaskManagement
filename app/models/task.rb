class Task < ApplicationRecord

  belongs_to :user
  validate  :set_nameless_name
  validates :name, presence: true, length: { maximum: 30 }

  private 

  def set_nameless_name
    self.name = '沒有該用戶' if name.nil?
  end
end

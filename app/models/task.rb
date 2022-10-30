class Task < ApplicationRecord

  belongs_to :user
  validate  :set_nameless_name
  validates :name, presence: true, length: { maximum: 30 }
  
  default_scope { order(created_at: :desc) }

  private 

  def set_nameless_name
    self.name = '沒有該用戶' if name.nil?
  end
end

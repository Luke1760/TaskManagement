class Task < ApplicationRecord

  belongs_to :user
  validate  :set_nameless_name
  validates :name, presence: true, length: { maximum: 30 }
  
  default_scope { order(created_at: :desc) }

  has_one_attached :avatar

  def self.csv_attributes 
    [:name, :description, :created_at, :updated_at]
  end

  def self.generate_csv
    CSV.generate(headers: true) do |csv|
      csv << csv_attributes
      all.each do |task|
        csv << csv_attributes.map { |attr| task.send(attr) }
      end
    end
  end

  private 

  def set_nameless_name
    self.name = '沒有該用戶' if name.nil?
  end
end

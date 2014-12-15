class Project < ActiveRecord::Base
  belongs_to :company
  has_many :works
  has_many :users, :through => :works

  validates :name, presence: true
  validates :company_id, presence: true
  validates :slug, length: {minimum: 3}
  validates :slug, uniqueness: true

  scope :low_rate, -> {where("default_rate < 100")}

  def to_s
    "#{name} (#{company})"
  end
end

class Project < ActiveRecord::Base
  belongs_to :company
  belongs_to :user
  has_many :works
  has_many :users, :through => :works

  validates :name, presence: true
  validates :default_rate, presence: true
  validates :company_id, presence: true
  validates :slug, length: {minimum: 3}
  validates :slug, uniqueness: true

  scope :low_rate, -> { where("default_rate < 100") }

  def to_s
    "#{name} (#{company})"
  end

  def self.export_csv(projects)
    CSV.generate() do |csv|
      csv << ['name', 'company', 'default_rate', 'created_at', 'owner', 'most recent work item']
      projects.each do |project|
        csv << [
            project.name,
            project.company,
            project.default_rate,
            project.created_at,
            project.user,
            project.works.order('created_at DESC').first
        ]
      end
    end
  end
end

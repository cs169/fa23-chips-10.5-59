# frozen_string_literal: true

class NewsItem < ApplicationRecord
  belongs_to :representative
  has_many :ratings, dependent: :delete_all

  def self.find_for(representative_id)
    NewsItem.find_by(
      representative_id: representative_id
    )
  end

  #make sure the issue is present AND is one of the following sectionsS
  validates :issue, presence: true, inclusion: { in: ["Free Speech", "Immigration", "Terrorism",
   "Social Security and Medicare", "Abortion", "Student Loans", "Gun Control", "Unemployment",
   "Climate Change", "Homelessness", "Racism", "Tax Reform", "Net Neutrality", "Religious Freedom",
   "Border Security", "Minimum Wage","Equal Pay"] }
end

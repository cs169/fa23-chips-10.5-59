class Representative < ApplicationRecord
  has_many :news_items, dependent: :delete_all

  def self.civic_api_to_representative_params(rep_info)
    reps = []

    rep_info["officials"].each_with_index do |official, index|
      ocdid_temp = ''
      title_temp = ''

      rep_info["offices"].each do |office|
        if office["officialIndices"].include? index
          title_temp = office["name"]
          ocdid_temp = office["divisionId"]
        end
      end

      existing_rep = Representative.find_by(ocdid: ocdid_temp, title: title_temp)

      if existing_rep
        reps.push(existing_rep)
      else
        rep = Representative.create!({ name: official.name, ocdid: ocdid_temp, title: title_temp})
        reps.push(rep)
      end
    end
    reps
  end
end

class Representative < ApplicationRecord
  has_many :news_items, dependent: :delete_all

  def self.civic_api_to_representative_params(rep_info)
    reps = []

    rep_info.officials.each_with_index do |official, index|
      ocdid_temp = ''
      title_temp = ''
      ###added##
      address = ''
      party = ''
      pic = 'Photo Unavalible'
      #####
  

      rep_info.offices.each do |office|
        if office.official_indices.include? index
          title_temp = office.name
          ocdid_temp = office.division_id 
        end
      end

      if rep_info&.officials&.any? # make sure it's not nil
          # get info from representativeInfoByAddress from the officials section
          curr_rep = rep_info.officials.find { |official| official["name"] == rep.name }
          if curr_rep  # make sure we find it
            address = curr_rep['address']
            party = curr_rep['party']
            pic = curr_rep['photoUrl']
          end
        end

      existing_rep = Representative.find_by(ocdid: ocdid_temp, title: title_temp)

      if existing_rep
        reps.push(existing_rep)
      else
        ##added more paramaters###
        rep = Representative.create!({ name: official.name, ocdid: ocdid_temp, title: title_temp,
         address: address, political_party: party, photo: pic})
        rep.save
        reps.push(rep)
      end
    end
    reps
  end
end

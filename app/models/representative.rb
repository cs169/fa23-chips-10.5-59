class Representative < ApplicationRecord
  has_many :news_items, dependent: :delete_all

  def self.civic_api_to_representative_params(rep_info)
    reps = []

    rep_info.officials.each_with_index do |official, index|
      ocdid_temp = ''
      title_temp = ''
      address = official.address
      party = official.party
      pic = official.photo_url



      if address.nil?
        address = "Address is unavalible."
      else
        address = address[0].line1 + "\n" + address[0].city + "\n" +address[0].zip
        
      end
  
      rep_info.offices.each do |office|
        if office.official_indices.include? index
          title_temp = office.name
          ocdid_temp = office.division_id 
        end
      end

      rep = find_or_create_by!({ name: official.name, ocdid: ocdid_temp, title: title_temp,
         address: address, political_party: party, photo: pic})
        
      reps.push(rep)

    end
    reps
  end
end

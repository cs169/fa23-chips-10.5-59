class Representative < ApplicationRecord
  has_many :news_items, dependent: :delete_all

  def self.civic_api_to_representative_params(rep_info)
    puts "rep_info: #{rep_info.inspect}"

    reps = []

    rep_info.officials.each_with_index do |official, index|
      ocdid_temp = ''
      title_temp = ''

      rep_info.offices.each do |office|
        if office['official_indices'].include? index
          title_temp = office['name']
          ocdid_temp = office['division_id']
        end
      end

      # Debugging: Print information about the representative being created
      puts "Creating representative with name: #{official.name}, ocdid: #{ocdid_temp}, title: #{title_temp}"

      rep = Representative.create!({ name: official.name, ocdid: ocdid_temp, title: title_temp })
      reps.push(rep)
    end

    # Debugging: Print information about offices and other relevant variables
    puts "rep_info.offices: #{rep_info.offices.inspect}"
    puts "reps: #{reps.inspect}"

    reps
  end
end

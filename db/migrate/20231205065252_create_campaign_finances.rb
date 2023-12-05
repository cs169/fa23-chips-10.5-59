class CreateCampaignFinances < ActiveRecord::Migration[5.2]
  def up
    create_table :campaign_finances do |t|
      t.string :canidate
      t.belongs_to :representative, index: true, null: false
      t.integer :cycle #election campaign year
      t.timestamps
    end
  end

  def down
    drop_table :campaign_finances
  end
end

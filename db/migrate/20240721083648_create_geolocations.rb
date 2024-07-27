class CreateGeolocations < ActiveRecord::Migration[7.0]
  def change
    create_table :geolocations do |t|
      t.string :ip_address, null: false, default: ''
      t.string :ip_address_type
      t.string :continent_name, default: ''
      t.string :continent_code, default: ''
      t.string :country, null: false, default: ''
      t.string :country_code, default: ''
      t.string :region, null: false, default: ''
      t.string :region_code, default: ''
      t.string :city, null: false, default: ''
      t.string :zip, null: false, default: ''
      t.float :latitude, null: false, default: ''
      t.float :longitude, null: false, default: ''
      t.string :timezone
      t.string :isp
      t.string :org
      t.string :offset
      t.string :host_name
      t.timestamps
    end

      add_index :geolocations, :ip_address, unique: true
      add_index :geolocations, [:latitude, :longitude]
  end
end

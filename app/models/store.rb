class Store < ApplicationRecord
    has_many :ratings #um store pode ter varios ratings
    validates_presence_of :lonlat, :name, :google_place_id #campos obrigatórios
    validates :google_place_id, uniqueness: true #torna o google_place_id unico

    #metodo que busca stores por proximidade
    scope :within, -> (longitude, latitude, distance_in_km = 5) {
       where(%{ST_Distance(lonlat, 'POINT(%f %f)') < %d} % [longitude, latitude, distance_in_km * 1000])
    }

    #media de estrelas do store
    def ratings_average
        return 0 if self.ratings.empty?
        (self.ratings.sum(:value) / self.ratings.count).to_i
    end
end

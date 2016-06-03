class Album < ActiveRecord::Base
  ALBUM_TYPES = %w(Studio Live)
  validates :band_id, :title, :presence => true
  validates :album_type, :inclusion => {in: ALBUM_TYPES }


  belongs_to :band,
    primary_key: :id,
    foreign_key: :band_id,
    class_name: "Band"

  has_many :tracks,
    primary_key: :id,
    foreign_key: :album_id,
    class_name: "Track",
    dependent: :destroy

  def self.album_types
    ALBUM_TYPES
  end

end

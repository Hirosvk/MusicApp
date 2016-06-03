class Track < ActiveRecord::Base
  TRACK_TYPES = %w(regular bonus)
  validates :title, :album_id, :presence => true
  validates :track_type, :inclusion => { in: TRACK_TYPES }

  belongs_to :album,
    primary_key: :id,
    foreign_key: :album_id,
    class_name: "Album"

  has_one :band,
    through: :album,
    source: :band


  has_many :notes,
    primary_key: :id,
    foreign_key: :track_id,
    class_name: "Note",
    dependent: :destroy


  def self.track_types
    TRACK_TYPES
  end

  def num_of_notes
    notes.count
  end

  def num_of_authors
    notes.distinct.count
  end

end

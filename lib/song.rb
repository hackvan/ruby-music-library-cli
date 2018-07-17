class Song
  extend Concerns::Findable

  attr_reader   :artist, :genre
  attr_accessor :name
  @@all = []

  def initialize(name, artist = nil, genre = nil)
    @name       = name
    self.artist = artist if artist
    self.genre  = genre  if genre
  end

  def self.create(name)
    Song.new(name).tap do |s|
      s.save
    end
  end
  
  def self.all
    @@all
  end

  def self.destroy_all
    @@all.clear
  end

  def save
    @@all << self
  end

  def artist=(artist)
    @artist = artist
    @artist.add_song(self) if artist.respond_to?(:add_song)
  end

  def genre=(genre)
    @genre = genre
    @genre.songs << self unless @genre.songs.include?(self)
  end

end
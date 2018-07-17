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
  
  def self.new_from_filename(file_name)
    parsed_filename = file_name.chomp(".mp3").split(" - ")
    artist_name = parsed_filename[0]
    song_name   = parsed_filename[1]
    genre_name  = parsed_filename[2]

    artist = Artist.find_or_create_by_name(artist_name)
    genre  = Genre.find_or_create_by_name(genre_name)
    Song.new(song_name, artist, genre)
  end

  def self.create_from_filename(file_name)
    self.new_from_filename(file_name).save
    self
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
class Artist
  extend  Concerns::Findable
  extend  Concerns::Sortable::ClassMethods
  include Concerns::Sortable::InstanceMethods
  
  attr_accessor :name, :songs
  @@all = []

  def initialize(name)
    @name  = name
    @songs = []
  end

  def self.create(name)
    new(name).tap { |a| a.save }
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

  def add_song(song)
    song.artist = self unless song.artist
    @songs << song unless @songs.include?(song)
  end

  def genres
    @songs.map(&:genre).uniq
  end

end
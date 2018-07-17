class Genre
  extend Concerns::Findable
  
  attr_accessor :name, :songs
  @@all = []

  def initialize(name)
    @name  = name
    @songs = []
  end

  def self.create(name)
    Genre.new(name).tap do |g|
      g.save
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

  def artists
    songs.map(&:artist).uniq
  end
end
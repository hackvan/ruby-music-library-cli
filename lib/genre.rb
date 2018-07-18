class Genre
  extend Concerns::Findable
  extend Concerns::Sortable::ClassMethods
  include Concerns::Sortable::InstanceMethods
  
  attr_accessor :name, :songs
  @@all = []

  def initialize(name)
    @name  = name
    @songs = []
  end

  def self.create(name)
    new(name).tap { |g| g.save }
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
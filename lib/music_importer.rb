class MusicImporter
  attr_reader :path, :files
  
  def initialize(path)
    @path  = path
    @files = []
    Dir["#{path}/*.mp3"].each do |file|
      @files << File.basename(file)
    end
  end

  def import
    @files.each do |file_name|
      Song.create_from_filename(file_name)
    end
  end
end
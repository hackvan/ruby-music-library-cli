module Concerns::Sortable
  module ClassMethods
    def all_sorted_by_name
      self.all.sort { |a, b| a.name <=> b.name }
    end
  end
  module InstanceMethods
    def songs_sorted_by_name
      self.songs.sort { |a, b| a.name <=> b.name }
    end
  end
end
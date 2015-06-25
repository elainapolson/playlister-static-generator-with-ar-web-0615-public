#to_slug module


  module Slugifiable 
    module ClassMethods
    end
    module InstanceMethods
      def to_slug
        self.name.downcase.gsub(" ", "-")
      end 
    end
  end

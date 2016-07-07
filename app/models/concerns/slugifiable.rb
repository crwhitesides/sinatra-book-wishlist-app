module Slugifiable
  module InstanceMethods

    def slug
      book_title = self.title
      book_title.strip.gsub(/[^a-zA-Z\d]/, "-").gsub(/\-{2,}/, "-").downcase
    end
  end

  module ClassMethods

    def find_by_slug(slug)
      self.all.detect { |instance| instance.slug == slug }
    end
  end

end
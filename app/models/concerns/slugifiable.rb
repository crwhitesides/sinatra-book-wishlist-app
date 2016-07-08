module Slugifiable
  module InstanceMethods

    def slug
      book_title = self.title
      book_title.strip.gsub(/[^a-zA-Z\d]/, "-").gsub(/\-{2,}/, "-").downcase
    end
  end

  module ClassMethods

    def find_by_slug(slug, session_user_id)
      books = self.all.find_all { |instance| instance.slug == slug }
      books.detect { |book| book.user_id == session_user_id }
    end
  end

end
class ApplicationRecord < ActiveRecord::Base

  include ImageConcern

  self.abstract_class = true
end

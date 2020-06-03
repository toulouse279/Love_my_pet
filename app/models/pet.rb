class Pet < ApplicationRecord
  belongs_to :user
  belongs_to :species, counter_cache: true

  validates :name, :gender, :birthday, presence: true
  validates :gender, format: {with: /\A(M|F)\z/}
  validates :avatar_file, presence: true, on: :create
  validate :birthday_not_future

  has_image :avatar
  has_and_belongs_to_many :posts

  after_destroy :destroy_posts

  def age
    Time.now.year - birthday.year
  end

  def birthday_not_future
    if birthday.present? && birthday.future?
      errors.add(:birthday, 'ne peut être dans le futur')
    end
  end

  private

  def destroy_posts
    Post.find_by_sql('SELECT * FROM posts LEFT JOIN pets_posts ON pets_posts.post_id = posts.id WHERE pets_posts.post_id IS NULL').each do |post|
      post.destroy
    end
  end

end

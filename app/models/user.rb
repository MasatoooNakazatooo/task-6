class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,:registerable,:recoverable, :rememberable, :validatable
         has_many :books, dependent: :destroy
         has_many :book_comments, dependent: :destroy
         has_many :favorites, dependent: :destroy
         attachment :profile_image
      validates :name, presence: true, length: {minimum: 2, maximum: 20}
      validates :introduction, length: {maximum: 50}
        # フォローしている側
          has_many :relationships, class_name: 'Relationship', foreign_key: 'following_id'
          has_many :followings, through: :relationships, source: :followed

        # フォローされている側
          has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: 'followed_id'
          has_many :followers, through: :reverse_of_relationships, source: :following


          # フォローするメソッド
          def follow(user)
            unless self == user
              # 見つかれば見つけて返してなければ作成→二重フォローを防ぐ
              relationships.find_or_create_by(followed_id: user.id)
            end
          end

          # フォローを外す
          def unfollow(user)
            relationship = relationships.find_by(followed_id: user.id)
            relationship.destroy if relationship
          end

          # フォローしているか確認
          def follow?(user)
            followings.include?(user)
          end
end
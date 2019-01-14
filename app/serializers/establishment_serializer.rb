class EstablishmentSerializer < ActiveModel::Serializer
  attributes :id,:name,:domain,:genre,:rating,:picture_url,:address,:latitude,:longitude
  has_one :user, through: :user_establishments
  has_many :visits
end

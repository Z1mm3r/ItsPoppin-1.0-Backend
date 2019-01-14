class UserSerializer < ActiveModel::Serializer
  attributes :id,:name,:activeVisit,:profile_picture_url
  has_many :user_establishments
  has_many :establishments, through: :user_establishments
  has_many :visits

  def activeVisit
    {id: self.object.activeVisit.id, user_id: self.object.activeVisit.user_id, establishment_id: self.object.activeVisit.establishment_id}
  end

  class EstablishmentSerializer < ActiveModel::Serializer
    attributes :id,:name
  end

end

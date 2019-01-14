class VisitSerializer < ActiveModel::Serializer
  attributes :id,:active
  belongs_to :user
  belongs_to :establishment
end

class User < ApplicationRecord
  has_many :user_establishments
  has_many :establishments, through: :user_establishments
  has_many :visits

  has_secure_password
  validates :name, uniqueness: {case_sensitive: false}
  validates :name, presence: true

  def toProtectedJson
    self.as_json(:only => [:id,:name])
  end

  def activeVisit

    currentActiveVisit = self.visits.find{|visit| visit.active == true}
    if(currentActiveVisit)
      return currentActiveVisit
    else
      currentActiveVisit = Visit.new
      return currentActiveVisit   
    end
  end

end

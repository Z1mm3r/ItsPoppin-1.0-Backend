class Establishment < ApplicationRecord
  has_one :user_establishment
  has_one :user, through: :user_establishment
  has_many :visits

  def currentVisitors
    visitors = 0
    self.visits.where(active: true).each do
      visitors += 1
    end
    return visitors
  end

  def self.radialSearch(amount,location,maxDistance)
    establishments = Establishment.all
    returnArray = []
    largest = nil

    establishments.map do |establishment|
      distance = Establishment.distance_to_miles(location,[establishment.latitude,establishment.longitude])
      if(largest == nil )
        largest =  distance
        returnArray.push([establishment,distance])
      elsif(returnArray.size < amount)
          returnArray.push([establishment,distance])
      else
        if(distance < largest)
          returnArray.pop()
          returnArray.push([establishment,distance])
        end
      end

      returnArray = returnArray.sort_by { |e| e[1] }
      largest = returnArray.last[1]
    end
    returnArray
  end

  def rating

    if(self.visits.size == 0)
      3
    else
      total = 0
      self.visits.each do |visit|
        if(visit.rating)
          total += visit.rating
        else
          total += 3
        end
      end
      total.to_f / self.visits.size
    end

  end


  def self.distance_to_miles(loc1,loc2)
    total = (loc1[0] - loc2[0]).abs
    total += (loc1[1] - loc2[1]).abs
    return (total * 97.5553)
  end

end

class DataSet < ApplicationRecord

  def self.get(name)
    d = DataSet.find_by_name(name)
    return if d.blank?
    d.refresh! if d.updated_at < d.ttl.minutes.ago
    data = JSON.parse(d.data)
    if d.first_key.present?
      data[d.first_key]
    else
      data
    end
  end

  def refresh!
    self.update data: transform(open(self.url).read)
    self
  end

  def transform(raw_json)
    return raw_json unless self.name == 'swapi'
end

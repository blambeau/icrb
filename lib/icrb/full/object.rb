require 'json'
class Object

  def to_json(*args, &bl)
    self.class.ics._to_json(self, *args, &bl)
  end

end

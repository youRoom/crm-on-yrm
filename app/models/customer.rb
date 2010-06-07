class Customer
  def self.all
    [{ :name => "Name1"}, { :name => "Name2"}]
  end

  def self.find(id)
    { :name => "Name1" }
  end

end

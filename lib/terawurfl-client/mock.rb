module TerawurflClient
  @mocking = false

  def self.mock!
    @mocking = true
  end

  def self.unmock!
    @mocking = false
    true
  end

  def self.mock?
    @mocking
  end
end

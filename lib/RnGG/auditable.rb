module RnGG
  module Auditable
    def audit
      "Rolled a #{self.number} (#{self.class})"
    end
  end
end

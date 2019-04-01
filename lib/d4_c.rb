require "d4_c/engine"
require 'd4_c/interface'

module D4C
  def self.interface(work_path: Rails.root)
    D4C::Interface.new(work_path: work_path)
  end
end

require_dependency "d4_c/application_controller"
require 'd4_c'

module D4C
  class PullController < ApplicationController
    def index
    end

    def callback
      pull!
    end

    def pull!
      D4C.interface.pull!
    end
  end
end

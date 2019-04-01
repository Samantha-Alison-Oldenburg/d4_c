require 'd4_c'

module D4C
  module PullHelper
    def delta_message
      behind = Proc.new { |delta| delta < 0 }
      same = Proc.new { |delta| delta == 0 }
      ahead = Proc.new { |delta| delta > 0 }

      case delta_from_remote
      when behind
        "We are currently #{delta_from_remote.abs} commits behind the remote."
      when same
        "We are currently up to date with the remote. No need to pull."
      when ahead
        "We are #{delta_from_remote} commits ahead of the remote."
      else
        raise StandardError, 'The delta_from_remote method broke'
      end
    end

    def current_branch
      @current_branch ||= repository.current_branch
    end

    def current_commit
      @current_commit ||= repository.current_commit
    end

    def delta_from_remote
      @delta_from_remote ||= repository.delta_from_remote
    end

    def repository
      D4C.interface.repository
    end
  end
end

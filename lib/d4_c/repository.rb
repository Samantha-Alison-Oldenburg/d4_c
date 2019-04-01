require 'd4_c/repository/git_helper'

module D4C
  class Repository
    include D4C::Repository::GitHelper
    attr_reader :work_path

    def initialize(work_path:)
      @work_path = work_path
      @current_reflog_head = reflog_head
    end

    def checkout!(revision:)
      git! "checkout #{revision}"
    end

    def pull!
      git! 'pull'
    end

    def files_changed
      return [] unless previous_reflog_head

      range = "#{previous_reflog_head}..#{current_reflog_head}"
      git "diff --name-only --diff-filter=ACM #{range}"

      git_output.split("\n")
    end

    # The branch that the local machine is on. Will be nil if you are
    # in detached head mode.
    def current_branch
      git 'rev-parse --abbrev-ref HEAD'
      git_output == 'HEAD' ? nil : git_output
    end

    # The sha of the commit the local head is on
    def current_commit
      git 'rev-parse HEAD'
      git_output
    end

    # Difference in commits between the current branch on local
    # machine and branch on remote.
    #
    # Returns an integer i where:
    # i == -n if and only if local is n commits behind remote
    # i == 0 if and only if local and remote on the same commit
    # i == +n if and only if local is n commits ahead of remote
    def delta_from_remote
      # Make sure we have up to date knowledge on remote.
      fetch

      git "rev-list --count #{current_branch}..origin/#{current_branch}"

      delta = git_output.to_i

      # We know we are behind remote if the first git command doesn't
      # return 0.
      return -delta if delta > 0

      # If we aren't behind the remote, we should check if we are
      # ahead of the remote.
      git "rev-list --count origin/#{current_branch}..#{current_branch}"
      git_output.to_i
    end

    def fetch
      git 'fetch'
    end
  end
end

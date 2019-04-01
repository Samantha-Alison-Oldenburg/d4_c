module D4C
  class Repository
    module GitHelper
      attr_reader :previous_reflog_head, :current_reflog_head

      def git_output
        if @git_output.is_a?(String)
          @git_output.chomp
        else
          @git_output
        end
      end

      # Execute a git command.
      #
      # When a call to #git! changes the reflog's HEAD, it means
      # files in the worktree have changed. We use two instance
      # variables, @current_reflog_head and @previous_reflog_head,
      # to keep track of the reflog's head before and after the git
      # command is ran. We use the diff of the two to get the files
      # that were changed.
      #
      # The most important thing to note is that if you think there is
      # any chance that your git command will modify the work tree,
      # use #git! instead of #git.
      #
      # Returns the repository class. You have to ask for the output
      # of the command via #git_output. But you can do something like
      # repository.git!(some_command).git_output
      def git!(command)
        git command

        @previous_reflog_head = current_reflog_head
        @current_reflog_head = reflog_head

        self
      end

      # Soft version of #git! that doesn't try to update the reflog
      # This is good for readonly git commands that don't change the
      # work tree. Examples: fetch, rev-parse, log.
      #
      # This is (mostly) just a convenience function to help you
      # distinguish between readonly and write commands. However,
      # #current_reflog_head needs to use #git, or else you'll have an
      # infinite loop.
      #
      # Returns the repository class. You have to ask for the output
      # of the command via #git_output. But you can do something like
      # repository.git(some_command).git_output
      def git(command)
        @git_output = exec_git(command: command)
        self
      end

      def reflog_head
        git 'reflog -n 1 --pretty="%H"'
        git_output
      end

      private

      def exec_git(command:)
        @last_command = git_command_preface + command
        %x( #{git_command_preface} #{command} )
      end

      def git_command_preface
        "git --git-dir=#{work_path}/.git --work-tree=#{work_path}"
      end
    end
  end
end

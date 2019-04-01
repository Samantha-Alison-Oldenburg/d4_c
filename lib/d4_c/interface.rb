require 'd4_c/repository'
require 'd4_c/file_loader'

module D4C
  class Interface
    attr_reader :work_path

    def initialize(work_path:)
      @work_path = work_path
    end

    def pull!
      repository.pull!
      load_changed_files!
    end

    def checkout!(revision:)
      repository.checkout!(revision: revision)
      load_changed_files!
    end

    def load_changed_files!
      file_loader(
        files: repository.files_changed.map { |file| work_path.join(file).to_s },
      ).load!
    end

    def repository
      @repository ||= D4C::Repository.new(work_path: work_path)
    end

    def file_loader(files:)
      D4C::FileLoader.new(files: files)
    end
  end
end

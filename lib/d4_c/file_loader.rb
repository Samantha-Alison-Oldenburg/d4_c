module D4C
  class FileLoader
    attr_reader :files

    LOADABLE_FILE_EXTENSIONS = ['.rb']

    def initialize(files:)
      @files = files
    end

    def load!
      failed = []
      loaded = []

      files_to_load, excluded = files.partition do |file|
        LOADABLE_FILE_EXTENSIONS.include?(File.extname(file))
      end

      excluded = excluded.map(&:to_s)

      files_to_load.each do |file|
        begin
          puts file
          load Rails.root.join(file).to_s
          loaded << file.to_s
        rescue Exception => e
          puts e
          failed << "#{file}: #{e.message}"
        end
      end

      {
        failed: failed,
        loaded: loaded,
        excluded: excluded,
      }
    end
  end
end

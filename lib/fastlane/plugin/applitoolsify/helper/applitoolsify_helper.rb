require 'fastlane_core/ui/ui'
require 'fileutils'
require 'zip'

module Fastlane
  UI = FastlaneCore::UI unless Fastlane.const_defined?("UI")

  module Helper
    class ApplitoolsifyHelper
      # class methods that you define here become available in your action
      # as `Helper::ApplitoolsifyHelper.your_method`
      #
      def self.show_message
        UI.message("Hello from the applitoolsify plugin helper!")
      end

      def self.applitoolsify(input, output)
        zip_ufg_lib = get_ufg_lib
        framework_zip_entries = get_framework_filenames(zip_ufg_lib)

        Zip::File.open(input, create: false) do |zipfile|
          framework_zip_entries.each do |zip_entry|
            new_path = File.join(File.basename(input), 'Frameworks', zip_entry.to_s)
            zip_entry.extract('tmp-file') do ||
              zipfile.add(new_path, 'tmp-file')
            end
          end
        end
        # require 'pry'
        # binding.pry
      end

      def self.get_ufg_lib
        url = 'https://applitools.jfrog.io/artifactory/ufg-mobile/UFG_lib.xcframework.zip'
        filename = File.basename(url) # 'UFG_lib.xcframework.zip'
        tmp_to = Dir.getwd
        where = File.expand_path(filename, tmp_to)
        open(url) {|cloud| File.write(where, cloud.read) } unless File.exist?(where)
        where
      end

      def self.get_framework_filenames(zip_ufg_lib)
        input_filenames = []
        Zip::File.open(zip_ufg_lib) do |zip_file|
          input_filenames = zip_file.select {|entry| entry.file? }
        end
        input_filenames
      end

    end
  end
end

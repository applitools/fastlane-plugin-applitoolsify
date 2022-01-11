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

      def self.applitoolsify(file_to_process, app_name)
        Dir.mktmpdir do |tmpdir|
          zip_ufg_lib = get_ufg_lib(tmpdir)
          framework_zip_entries = get_framework_filenames(zip_ufg_lib)

          Zip.continue_on_exists_proc = true
          Zip::File.open(file_to_process, create: false) do |zipfile|
            framework_zip_entries.each do |zip_entry|
              new_path = get_new_path(zip_entry.to_s, app_name)
              ext_path = extract_zip_entry(tmpdir, zip_ufg_lib, zip_entry)
              zipfile.add(new_path, ext_path)
            end
          end
          # require 'pry'
          # binding.pry
        end
      end

      def self.get_ufg_lib(tmpdir)
        url = 'https://applitools.jfrog.io/artifactory/ufg-mobile/UFG_lib.xcframework.zip'
        filename = File.basename(url)
        where = File.expand_path(filename, tmpdir)
        open(url) {|cloud| File.write(where, cloud.read) } unless File.exist?(where)
        where
      end

      def self.get_framework_filenames(zip_ufg_lib)
        input_filenames = []
        Zip::File.open(zip_ufg_lib) {|zip_file| input_filenames = zip_file.select {|entry| entry.file? } }
        input_filenames
      end


      def self.extract_zip_entry(tmpdir, zip_ufg_lib, zip_entry)
        lib_path = File.basename(zip_ufg_lib, File.extname(zip_ufg_lib))
        ext_path = File.join(tmpdir, lib_path, zip_entry.name)
        dirname = File.dirname(ext_path)
        FileUtils.mkdir_p(dirname) unless File.directory?(dirname)
        zip_entry.extract ext_path
        ext_path
      end

      def self.get_new_path(zip_path, app_name)
        if zip_path.to_s.start_with?('__MACOSX')
          File.join(zip_path.to_s.split('/').insert(1, app_name, 'Frameworks'))
        else
          File.join(app_name, 'Frameworks', zip_path.to_s)
        end
      end

    end
  end
end

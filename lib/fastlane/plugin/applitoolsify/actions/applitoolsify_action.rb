require 'fastlane/action'
require_relative '../helper/applitoolsify_helper'

module Fastlane
  module Actions
    class ApplitoolsifyAction < Action
      def self.run(params)
        UI.message("The applitoolsify plugin is working!")
        UI.message("Parameter Input Path: #{params[:applitoolsify_input]} >")
        UI.message("Parameter Output Path: > #{params[:applitoolsify_output]}")

        input = params[:applitoolsify_input]
        output = params[:applitoolsify_output]

        r = Helper::ApplitoolsifyHelper.applitoolsify(input, output)
        UI.message("r : #{r}")
      end

      def self.description
        "Add Applitools SDKs to ipa and app iOS apps as fastlane-plugin"
      end

      def self.authors
        ["Serhii Ovchynnyk"]
      end

      def self.return_value
        # If your method provides a return value, you can describe here what it does
      end

      def self.details
        # Optional:
        "Add Applitools SDKs to ipa and app iOS apps as fastlane-plugin"
      end

      def self.available_options
        [
          # FastlaneCore::ConfigItem.new(key: :your_option,
          #                         env_name: "APPLITOOLSIFY_YOUR_OPTION",
          #                      description: "A description of your option",
          #                         optional: false,
          #                             type: String)
          FastlaneCore::ConfigItem.new(key: :applitoolsify_input,
                                       env_name: "APPLITOOLSIFY_INPUT",
                                       description: "Path to your original file to modify",
                                       optional: false,
                                       type: String,
                                       verify_block: proc do |value|
                                         UI.user_error!("Could not find file at path '#{File.expand_path(value)}'") unless File.exist?(value)
                                         UI.user_error!("'#{value}' doesn't seem to be an valid file") unless value.end_with?(".ipa") || value.end_with?(".app")
                                       end),
          FastlaneCore::ConfigItem.new(key: :applitoolsify_output,
                                       env_name: "APPLITOOLSIFY_OUTPUT_NAME",
                                       description: "The name of the resulting file",
                                       optional: false,
                                       type: String),
        ]
      end

      def self.is_supported?(platform)
        # Adjust this if your plugin only works for a particular platform (iOS vs. Android, for example)
        # See: https://docs.fastlane.tools/advanced/#control-configuration-by-lane-and-by-platform
        #
        # [:ios, :mac, :android].include?(platform)
        true
      end
    end
  end
end

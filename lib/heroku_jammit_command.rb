module Heroku::Command
  class Jammit < BaseWithApp

    def index
      display "===== Compiling assets..."

      %x{ jammit -f }

      display "===== Commiting assets..."

      commite_assets
      #%x{ git commit -am 'assets' }
    end

    private

      def commite_assets
        file = open(config_file_path) {|f| YAML.load(f) }
        package_dir = "public/" + (file["package_path"] || "assets")
        git add package_dir
        git commit -m "assets #{Time.now}"
      end

      def config_file_path
        File.join(Dir.getwd, 'config', 'assets.yml')
      end

      def missing_config_file?
        !File.exists? config_file_path
      end
  end
end


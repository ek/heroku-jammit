module Heroku::Command
  class Jammit < BaseWithApp

    def index
      is_root?

      display "===== Compiling assets...", false

      run "jammit -f"

      display "===== Commiting assets...", false

      commit_assets

      display "===== Done..."
    end

    private

      def commit_assets
        file = open(config_file_path) {|f| YAML.load(f) }
        package_dir = "public/" + (file["package_path"] || "assets")
        run "git add '#{package_dir}' && git commit -m 'assets #{formatted_date(Time.now)}'"
      end

      def config_file_path
        File.join(Dir.getwd, 'config', 'assets.yml')
      end

      def missing_config_file?
        !File.exists? config_file_path
      end

      def is_root?
        if missing_config_file?
          display "app rails not found!, you need stay on the root of one rails app"
          exit
        end
      end

      def run(cmd)
        begin
          shell(cmd)
          display "[OK]"
        rescue
          display "[FAIL]"
        end
      end

      def formatted_date(date)
        date.strftime("%A %d, %Y")
      end

  end
end


module Heroku::Command
  class Jammit < BaseWithApp

    def index
      display "===== Compiling assets..."

      %x{ jammit -f }

      display "===== Commiting assets..."

      %x{ git commit -am 'assets' }
    end

    private

    def system_with_echo(*args)
      puts args.join(' ')
      system(*args)
    end

  end
end


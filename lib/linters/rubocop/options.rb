require "linters/rubocop/tokenizer"

module Linters
  module Rubocop
    class Options
      def command(_filename)
        "rubocop"
      end

      def config_filename
        ".rubocop.yml"
      end

      def tokenizer
        Tokenizer.new
      end

      def config_content(content)
        if YAML.safe_load(content, [Regexp]).any?
          content
        end
      end
    end
  end
end

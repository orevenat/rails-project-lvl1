# frozen_string_literal: true

module HexletCode
  module Tag
    SELF_CLOSING_TAGS = %i[area base input link br hr img].freeze

    def self.build(tag_name, options = {}, &)
      default_options = default_options_for(tag_name.to_sym)
      options.merge!(default_options.reject { |key, _| options.key? key })

      opts = options.except(:body)
                    .map { |key, value| "#{key}=\"#{value}\"" }
                    .join(' ')

      if HexletCode::Tag::SELF_CLOSING_TAGS.include?(tag_name.to_sym)
        render_single_tag(tag_name, opts)
      else
        render_tag(tag_name, options[:body], opts, &)
      end
    end

    def self.render_single_tag(tag_name, options)
      opts = options.then { |current| current.size.positive? ? " #{current}" : current }
      "<#{tag_name}#{opts}>"
    end

    def self.render_tag(tag_name, body, options)
      opts = options.then { |current| current.size.positive? ? " #{current}" : current }
      final_body = block_given? ? yield : body.to_s
      "<#{tag_name}#{opts}>#{final_body}</#{tag_name}>"
    end

    def self.default_options_for(tag)
      case tag
      when :textarea
        { cols: 20, rows: 40 }
      else
        {}
      end
    end
  end
end

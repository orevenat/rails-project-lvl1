# frozen_string_literal: true

module HexletCode
  module Tag
    SELF_CLOSING_TAGS = %i[area base input link br hr img].freeze

    def self.build(tag_name, options = {}, &block)
      default_options = self.default_options_for(tag_name.to_sym)
      options.merge!(default_options.select{ |k,_| not options.has_key? k })

      opts =  options.except(:body)
                     .map { |key, value| "#{key}=\"#{value}\"" }
                     .join(' ')
                     .yield_self { |it| it.size.positive? ? " #{it}" : it }

      self_closing_tag = HexletCode::Tag::SELF_CLOSING_TAGS.include?(tag_name.to_sym)
      tag_end = self_closing_tag ? '' : "</#{tag_name}>"
      body = self_closing_tag ? '' : (yield block if block_given?)
      "<#{tag_name}#{opts}>#{options[:body]}#{body}#{tag_end}"
    end

    private

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

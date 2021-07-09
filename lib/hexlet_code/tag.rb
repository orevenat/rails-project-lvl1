# frozen_string_literal: true

module HexletCode
  module Tag
    SELF_CLOSING_TAGS = %i[area base input link br hr img]

    def self.build(name, options = {}, &block)
      opts = options.map { |key, value| "#{key}=\"#{value}\"" }
                    .join(' ')
                    .yield_self { |it| it.size.positive? ? " #{it}" : it }

      self_closing_tag = HexletCode::Tag::SELF_CLOSING_TAGS.include?(name.to_sym)
      tag_end = self_closing_tag ? '' : "</#{name}>"
      body = self_closing_tag ? '' : (yield block)
      "<#{name}#{opts}>#{body}#{tag_end}"
    end
  end
end

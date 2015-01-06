module Jekyll
  module Tags
    class MarkdownTag < Liquid::Block

      def initialize(tag_name, markup, tokens)
        super
      end

      def render(context)
        site = context.registers[:site]
        converter = site.getConverterImpl(::Jekyll::Converters::Markdown)
        output = converter.convert(super(context))
        "#{output}"
      end
    end
  end
end

Liquid::Template.register_tag('markdown', Jekyll::Tags::MarkdownTag)
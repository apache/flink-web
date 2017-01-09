module Jekyll
  class PageToc < Liquid::Tag

    def initialize(tag_name, input, tokens)
      super
      @input = input
    end
# Usage: github $PATH [$TAG: master]
    
    def render(context)
'<div class="page-toc" markdown="1">
* toc
{:toc}
</div>'
    end
  end
end

Liquid::Template.register_tag('toc', Jekyll::PageToc)
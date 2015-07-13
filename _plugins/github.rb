module Jekyll
  class GitHubLink < Liquid::Tag

    def initialize(tag_name, input, tokens)
      super
      @input = input
    end
# Usage: github $PATH [$TAG: master] [$TEXT]
    
    def render(context)
      input = @input.gsub(/"/, "").split
      config = context.registers[:site].config

      path = input[0]

      # tag precendence:
      # 1. input[1],
      # 2. "master" (default)
      gh_tag = input[1].nil? ? "master" : input[1]

      url = "#{config["github"]}/tree/#{gh_tag}/#{path}"

      text = input.length > 2 ? input[2..-1].join(" ") : url

      "<a href='#{url}'>#{text}</a>"
    end
  end
end

Liquid::Template.register_tag('github', Jekyll::GitHubLink)
module Jekyll
  class GitHubLink < Liquid::Tag

    def initialize(tag_name, input, tokens)
      super
      @input = input
    end
# Usage: github $PATH [$TAG: master]
    
    def render(context)
      input = @input.sub(/".*"/, "").split
      config = context.registers[:site].config

      path = input[0]

      # tag precendence:
      # 1. input[1],
      # 2. "master" (default)
      gh_tag = input[1].nil? ? "master" : input[1]

      "#{config["github"]}/tree/#{gh_tag}/#{path}"
    end
  end
end

Liquid::Template.register_tag('github', Jekyll::GitHubLink)
require "open3"

def exec_pandoc(input, from)
  pandoc_command = "pandoc -f #{from} -t html"
  logger.debug 'pandoc_command: ' + pandoc_command
  output, status = Open3.capture2(pandoc_command, :stdin_data=>input)
  output
end

class MainController < ApplicationController
  def index
    @input_md = ''
    @output_pandoc = ''
    @output_github = ''
    @output_multi = ''
  end

  def convert
    @input_md = params[:'input-markdown']

    @output_pandoc = exec_pandoc(@input_md, 'markdown')
    @output_github = exec_pandoc(@input_md, 'markdown_github')
    @output_multi  = exec_pandoc(@input_md, 'markdown_mmd')

    render action: :index
  end
end

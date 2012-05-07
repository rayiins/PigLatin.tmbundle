#!/usr/bin/env ruby

require "#{ENV['TM_SUPPORT_PATH']}/lib/tm/executor"
require "#{ENV['TM_SUPPORT_PATH']}/lib/tm/save_current_document"

TextMate.save_current_document
TextMate::Executor.make_project_master_current_document

cmd = ENV['TM_PIGCMD']
script_args = ENV['TM_FILEPATH']

TextMate::Executor.run(cmd, :version_args => ["--version"], :script_args => script_args) do |line, type|
  case type
  when :err
    line.chomp!
    if line =~ /(.+\.pig):(\d+):(.*)$/ 
      path = Pathname.new($1)
      line_no = $2
      error = $3
      abs_path = Pathname.new(path.realpath)
      line = "<a href='txmt://open?url=file://#{abs_path}&line=#{line_no}'>#{htmlize((path.to_s =~ /^\.\//) ? path : abs_path.relative_path_from(cwd))}:#{line_no}</a>:#{htmlize(error)}";
    else
      line = htmlize(line)
    end
    line = "<span style='color: red'>#{line}</span><br>"
  end
end
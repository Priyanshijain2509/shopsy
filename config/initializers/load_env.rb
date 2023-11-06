# frozen_string_literal: true

if File.exist?('.env')
  File.read('.env').split.each do |line|
    parts = line.split('=')
    ENV[parts[0]] = parts[1] if parts.length == 2
  end
end

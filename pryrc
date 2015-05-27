Pry.config.theme = 'tomorrow'

pwd = Dir.pwd.sub(ENV['DEVELOPER'], '~Developer').sub(ENV['HOME'], '~')
pwd = pwd.split('/')
pwd = pwd[-2,2] if pwd.size > 2

Pry.config.prompt_name = "#{pwd.join('/')} "

Pry.config.theme = 'tomorrow'

pwd = Dir.pwd.sub(ENV['CODE'], '~Code').sub(ENV['HOME'], '~')
pwd = pwd.split('/')
pwd = pwd[-2,2] if pwd.size > 2

Pry.config.prompt_name = "#{pwd.join('/')} "

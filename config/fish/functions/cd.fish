function cd
  builtin cd $argv[1]

  set -x PATH $PATH[2..-1]
  set -x PATH $PWD/bin $PATH ^/dev/null
end

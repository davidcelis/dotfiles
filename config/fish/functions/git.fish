function _has_working_hub
  echo (which hub ^/dev/null)
end

function git
  if [ (_has_working_hub) ]
    hub $argv
  else
    command git $argv
  end
end

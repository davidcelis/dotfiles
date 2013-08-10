function git
  if [ (which hub) ]
    hub $argv
  else
    command git $argv
  end
end

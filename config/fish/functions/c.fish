function c
  cd $CODE
  for dir in $argv
    cd $dir*
  end
end

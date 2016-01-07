function __fish_prompt_pwd
  echo $PWD | sed -e "s|^$DEVELOPER|~Developer|" -e "s|^$HOME/*|~|" -e 's-.*/\([^/]*/[^/]*\)-\1-'
end

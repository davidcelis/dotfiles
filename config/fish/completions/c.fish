function __c_complete_directory
  set -g CODE_DIR $CODE
  set code_dirs (echo (commandline) | tr ' ' \n)
  set -e code_dirs[1]

  for dir in $code_dirs
    set -g CODE_DIR "$CODE_DIR/$dir"
  end

  if [ -d $CODE_DIR ]
    command ls -d $CODE_DIR/*/ | xargs -n1 basename
  else
    command ls -d $CODE_DIR*/ | xargs -n1 basename
  end
end

complete -xc c -a "(__c_complete_directory)"

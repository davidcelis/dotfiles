function _vim
  if test -x $HOME/Applications/MacVim.app/Contents/MacOS/Vim
    echo "~/Applications/MacVim.app/Contents/MacOS/Vim"
  else if test -x /Applications/MacVim.app/Contents/MacOS/Vim
    echo "/Applications/MacVim.app/Contents/MacOS/Vim"
  else
    echo "vim"
  end
end

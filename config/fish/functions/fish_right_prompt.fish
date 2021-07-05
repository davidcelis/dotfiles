function fish_right_prompt
  set -l red (set_color red)
  set -l normal (set_color normal)

  if contains rbenv (functions)
    echo $red(rbenv version-name)$normal
  else if contains asdf (functions)
    echo $red(asdf current ruby | awk '{print $2}')$normal
  end
end

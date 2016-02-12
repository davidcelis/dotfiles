function fish_right_prompt
  if contains rbenv (functions)
    set -l red (set_color red)
    set -l normal (set_color normal)

    echo $red(rbenv version-name)$normal
  end
end

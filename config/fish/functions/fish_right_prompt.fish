function fish_right_prompt
  if contains fry (functions)
    set -l red (set_color red)
    set -l normal (set_color normal)

    echo $red(fry current)$normal
  end
end

function fish_right_prompt
  if [ (which rbenv ^/dev/null) ]
    echo (rbenv version-name)
  end
end

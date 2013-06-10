function fish_prompt
  if not set -q -g __git_functions_defined
    set -g __git_functions_defined
    function _git_branch_name
      echo (git symbolic-ref HEAD ^/dev/null | sed -e 's|^refs/heads/||')
    end

    function _git_dirty
      echo (git status -s --ignore-submodules=dirty ^/dev/null)
    end

    function _git_ahead
      echo (git log origin/(_git_branch_name)..(_git_branch_name) ^/dev/null)
    end

    function _git_behind
      echo (git log (_git_branch_name)..origin/(_git_branch_name) ^/dev/null)
    end
  end

  set -l cyan (set_color -o cyan)
  set -l yellow (set_color -o yellow)
  set -l purple (set_color -o purple)
  set -l blue (set_color -o blue)
  set -l normal (set_color normal)

  set -l cwd $cyan(prompt_pwd)

  if [ (_git_branch_name) ]
    set -l git_branch $purple(_git_branch_name)
    set git_info "$blue $git_branch"

    if [ (_git_dirty) ]
      set -l dirty "$yellow!"
      set git_info "$git_info$dirty"
    end

    if [ (_git_ahead) ]
      set -l ahead "$blue↑"
      set git_info "$git_info$ahead"
    end

    if [ (_git_behind) ]
      set -l behind "$blue↓"
      set git_info "$git_info$behind"
    end
  end

  echo -n -s $cwd $git_info $normal ' % '
end

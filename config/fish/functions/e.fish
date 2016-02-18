function e
  if [ (count $argv) -gt 0 ]
    atom $argv
  else
    set -l out (mktemp -d)

    cat > $out/stdin
    atom $out/stdin
  end
end

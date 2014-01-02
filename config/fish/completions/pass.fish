function __pass_complete
  security dump-keychain | grep '"srvr"' | cut -d '"' -f 4 -
end

complete -xc pass -a "(__pass_complete)"

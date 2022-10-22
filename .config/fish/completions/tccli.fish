complete -c tccli -f -a '(
    begin
        set -lx COMP_SHELL fish
        set -lx COMP_LINE (commandline)
        tccli_completer
    end
)'

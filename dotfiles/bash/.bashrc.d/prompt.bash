# bash_or_nixed_bash() {
#     if [ -n "$IN_NIX_SHELL" ]; then 
#         echo "nix | bash"; 
#     else 
#         echo "bash"; 
#     fi
# }

prompt_or_nixed_prompt() {
    if [ -n "$IN_NIX_SHELL" ]; then 
        echo "nix $"; 
    else 
        echo "$"; 
    fi
}

source ~/.nix-profile/share/bash-completion/completions/git-prompt.sh

start_green_text="\[\e[32m\]"
end_green_text="\[\e[00m\]"

export PS1="\n${start_green_text}bash | \u@\h | \w \$(__git_ps1 '(%s)') ${end_green_text} \n\$(prompt_or_nixed_prompt) "


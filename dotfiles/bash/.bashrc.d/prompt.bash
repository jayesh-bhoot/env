source ~/.nix-profile/share/bash-completion/completions/git-prompt.sh

# : Approach 1: Single workflow, special-case branches:
# : single PS1, which calls functions that deal with nix and non-nix cases for specific portions.
# bash_or_nixed_bash() {
#     if [ -n "$IN_NIX_SHELL" ]; then 
#         echo "nix | bash"; 
#     else 
#         echo "bash"; 
#     fi
# }
# prompt_or_nixed_prompt() {
#     if [ -n "$IN_NIX_SHELL" ]; then 
#         echo "nix $"; 
#     else 
#         echo "$"; 
#     fi
# }
# start_green_text="\[\e[32m\]"
# end_green_text="\[\e[00m\]"
# export PS1="\n${start_green_text}bash | \u@\h | \w \$(__git_ps1 '(%s)') ${end_green_text} \n\$(prompt_or_nixed_prompt) "

# ==========

# : Approach 2: Separate workflows, reuse common portions:
# : Keep nix and non-nix prompts separate from the start. Reuse only common portions.
# : This is a much more manageable approach.
prompt() {
    # In computer science, an escape sequence is a combination of characters that has a meaning other than the literal characters contained therein.
    # It is marked by one or more preceding (and possibly terminating) characters
    # Syntax of colour code escape sequence: \033[code1;code2;codeNm where
    # \033[ indicates the beginning of an escape sequence. \033 is the octal value of ESC ASCII character. \e is the equivalent of \033 in bindkey. \033 is the most standard.
    # code1;code2;codeN specifies a series of numbers, which indicate either of:
    #   font style (00 -> normal; 01 -> bold; 04 -> underlined; 05 -> blinking)
    #   foreground colour code. An fg colour code starts with 4. eg., 32 is green.
    #   background colour code. A bg colour code starts with 4. eg., 42 is green.
    # m indicates that the sequence is a colour code?
    # eg., \033[01;04;37;42m formats the subsequent text as bold + underlined + white fg + green bg.

    # Always make sure to reset the colour sequence with \033[00m

    # When to put square brackets around escape sequences?
    # First, bash doesn't define colors. In fact bash has absolutely no idea that colors even exist.
    # All it knows is that you told it to output the characters \033[0;36m.
    # Your terminal emulator (xterm, gnome-terminal, whatever) receives these characters and understands "I need to start outputting in cyan".
    # Now back to bash. As you may have noticed, when I've been referring to the cyan color, I've been using \033[0;36m, not \[\033[0;36m\].
    # The square brackets have been missing. The purpose of the square brackets is that when using escape codes (colors) in the prompt,
    # bash has to know which characters are non-printing (zero-width, don't actually show anything).
    # Thus you enclose non-printing characters in \[ \].
    # If you remove these characters, everything might appear to work just fine at first,
    # but you'll start running into all sorts of weirdness when your command exceeds the terminal width.
    # Square brackets are usually only relevant in the prompt.

    local reset_colour_sequence="\033[00m"
    local user_host="$USER@$HOSTNAME"
    local current_dir=$(pwd | sed "s|^$HOME|~|")
    local git_prompt="$(__git_ps1 '(%s)')"

    local black_fg="30"
    local green_fg="32"
    local brown_fg="33"
    local blue_fg="34"
    local light_gray_bg="47"

    if [ -n "$IN_NIX_SHELL" ]; then 
        # Why use printf over echo?
        # printf is more consistent across versions than echo. Also, echo does not evaluate for safety reasaons.

        # printf does not need to enclose escape sequence with [].
        # So PS1="\[\033[37m\]bash$", while printf "\033[37mbash$"

        local colour_sequence="\033[${blue_fg};${light_gray_bg}m"
        printf "\n${colour_sequence}nix-shell | bash | ${user_host} | ${current_dir} ${git_prompt} ${reset_colour_sequence} \n$ "
    else 
        local colour_sequence="\033[${black_fg};${light_gray_bg}m"
        printf "\n${colour_sequence}bash | ${user_host} | ${current_dir} ${git_prompt} ${reset_colour_sequence} \n$ "
    fi
}
export PS1="\$(prompt)"

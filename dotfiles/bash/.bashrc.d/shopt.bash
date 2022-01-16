HISTCONTROL=ignorespace:ignoredups:erasedups
HISTSIZE=5000
HISTFILESIZE=5000

# Append rather than overwrite Bash history
shopt -s histappend
# Put multi-line commands onto one line of history
shopt -s cmdhist

shopt -s autocd 
shopt -s cdspell 
shopt -s direxpand
shopt -s dirspell 

# Include dotfiles in pattern matching
shopt -s dotglob
# Enable advanced pattern matching
shopt -s extglob
# Enable double-starring paths
shopt -s globstar
# $'string' and $"string" quoting is performed within ${parameter} expansions enclosed in double quotes.
shopt -s extquote 
# match filenames in a case-insensitive fashion when performing pathname expansion
shopt -s nocaseglob 

# Update columns and rows if window size changes
shopt -s checkwinsize

# Warn me about stopped jobs when exiting
shopt -s checkjobs

# Update the hash table properly
shopt -s checkhash

# Don't use Bash's builtin host completion
shopt -u hostcomplete
# Use programmable completion, if available
shopt -s progcomp
# Ignore me if I try to complete an empty line
shopt -s no_empty_cmd_completion

# Warn me if I try to shift when there's nothing there
shopt -s shift_verbose

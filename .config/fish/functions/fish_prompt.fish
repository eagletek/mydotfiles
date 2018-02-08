function fish_prompt
	# Just calculate this once, to save a few cycles when displaying the prompt
	if not set -q __fish_prompt_hostname
		set -g __fish_prompt_hostname (hostname|cut -d . -f 1)
	end

# blue/green/gray
#    echo -n -s \
#         (set_color --background=blue white) "$USER" @ "$__fish_prompt_hostname" \
#         (set_color --background=green blue) <U+E0B0> \
#         (set_color --background=green black) (__fish_git_prompt "<U+E0A0>%s") \
#         (set_color --background=black green) <U+E0B0> \
#         (set_color --background=black 8AE234) (prompt_pwd) \
#         (set_color --background=normal black)  " " \
#         (set_color normal)

    # red/white/gray
    echo -n -s \
         (set_color --background=600 fff) "$USER" @ "$__fish_prompt_hostname" \
         (set_color --background=fff 600)  \
         (set_color --background=fff 600) (__fish_git_prompt "%s") \
         (set_color --background=black fff)  \
         (set_color --background=black fff) (prompt_pwd) \
         (set_color --background=normal black)  " " \
         (set_color normal)
end

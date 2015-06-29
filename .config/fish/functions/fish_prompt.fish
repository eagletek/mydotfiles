function fish_prompt
	# Just calculate this once, to save a few cycles when displaying the prompt
	if not set -q __fish_prompt_hostname
		set -g __fish_prompt_hostname (hostname|cut -d . -f 1)
	end

    echo -n -s \
         (set_color --background=blue white) "$USER" @ "$__fish_prompt_hostname" \
         (set_color --background=green blue)  \
         (set_color --background=green black) (__fish_git_prompt "%s") \
         (set_color --background=black green)  \
         (set_color --background=black 8AE234) (prompt_pwd) \
         (set_color --background=normal black)  " " \
         (set_color normal)
end

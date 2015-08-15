function fish_title
    if not set -q __fish_prompt_hostname
        set -g __fish_prompt_hostname (hostname -s)
    end

    echo -n -s "$USER@$__fish_prompt_hostname: "(prompt_pwd)
end

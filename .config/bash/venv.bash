
export VIRTUAL_ENV_BASE_PATH="${HOME}/.venv"
mkdir -p "${VIRTUAL_ENV_BASE_PATH}"

function venv() {
  if [[ $# -ne 1 ]]; then
    echo "Must provide virtual environment name"
    return
  fi

  local venv_name="${1}"
  local venv_path="${VIRTUAL_ENV_BASE_PATH}/${venv_name}"
  if [[ -d "${venv_path}" ]]; then
    source "${venv_path}/bin/activate"
  else
    virtualenv --python=python3 "${venv_path}"
    source "${venv_path}/bin/activate"
  fi
}

function _venv_completions() {
  if [ "${#COMP_WORDS[@]}" != "2" ]; then
    return
  fi
  COMPREPLY=($(compgen -W "$(\ls "${VIRTUAL_ENV_BASE_PATH}")" -- "${COMP_WORDS[1]}"))
}
complete -F _venv_completions venv

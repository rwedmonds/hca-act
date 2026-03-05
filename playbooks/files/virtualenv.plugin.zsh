# function virtualenv_prompt_info(){
#   [[ -n ${VIRTUAL_ENV} ]] || return
#   echo "${ZSH_THEME_VIRTUALENV_PREFIX=[}${VIRTUAL_ENV:t:gs/%/%%}${ZSH_THEME_VIRTUALENV_SUFFIX=]}"
# }
#
# function venv_info() {
#     if [[ -n "$VIRTUAL_ENV" ]]; then
#         echo "‹${VIRTUAL_ENV:t}›"
#     fi
# }
#
# # disables prompt mangling in virtual_env/bin/activate
# export VIRTUAL_ENV_DISABLE_PROMPT=1
#
function virtualenv_info { 
    [ $VIRTUAL_ENV ] && echo '('`basename $VIRTUAL_ENV`') '
}

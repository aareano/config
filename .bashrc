export PATH=$PATH:~/git/depot_tools
export GYP_CHROMIUM_NO_ACTION=1

RED="$(tput setaf 1)"
GREEN="$(tput setaf 2)"
YELLOW="$(tput setaf 3)"
BLUE="$(tput setaf 4)"
MAGENTA="$(tput setaf 5)"
CYAN="$(tput setaf 6)"
WHITE="$(tput setaf 7)"
RESET="$(tput sgr0)"

# get current branch in git repo
function parse_git_branch() {
    BRANCH=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
    if [ ! "${BRANCH}" == "" ]
    then
        STAT=`parse_git_dirty`
        echo "${GREEN}[${BRANCH}${RESET}${STAT}${GREEN}]${RESET} "
    else
        echo ""
    fi
}

# get current status of git repo
function parse_git_dirty {
    status=`git status 2>&1 | tee`
    gdiff=`git diff 2>&1 | tee`

    pcount=`echo -n "${gdiff}" 2> /dev/null | grep '^+[^+]' | wc -l | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//'`
    mcount=`echo -n "${gdiff}" 2> /dev/null | grep '^-[^-]' | wc -l | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//'`

    dirty=`echo -n "${status}" 2> /dev/null | grep "modified:" &> /dev/null; echo "$?"`
    untracked=`echo -n "${status}" 2> /dev/null | grep "Untracked files" &> /dev/null; echo "$?"`
    ahead=`echo -n "${status}" 2> /dev/null | grep "Your branch is ahead of" &> /dev/null; echo "$?"`
    newfile=`echo -n "${status}" 2> /dev/null | grep "new file:" &> /dev/null; echo "$?"`
    renamed=`echo -n "${status}" 2> /dev/null | grep "renamed:" &> /dev/null; echo "$?"`
    deleted=`echo -n "${status}" 2> /dev/null | grep "deleted:" &> /dev/null; echo "$?"`

    bits=''
    
    if [ "${renamed}" == "0" ]; then
        bits=">${BLUE}${bits}"
    fi
    if [ "${ahead}" == "0" ]; then
        bits="${WHITE}*${bits}"
    fi
    if [ "${newfile}" == "0" ]; then
        bits="${GREEN}+${bits}"
    fi
    if [ "${untracked}" == "0" ]; then
        bits="${WHITE}?${bits}"
    fi
    if [ "${deleted}" == "0" ]; then
        bits="${RED}x${bits}"
    fi
    if [ "${dirty}" == "0" ]; then
        dirtybits="" # "${YELLOW}~"
        if [ ! "${pcount}" == "0" ]; then
            dirtybits="${dirtybits}${GREEN}+${pcount}"
        fi
        if [ ! "${mcount}" == "0" ]; then
            dirtybits="${dirtybits}${RED}-${mcount}"
        fi
        bits="${dirtybits}${bits}"
    fi
    if [ ! "${bits}" == "" ]; then
        echo " ${bits}"
    else
        echo ""
    fi
}

export PS1="\t \u | \w \`parse_git_branch\`$ "

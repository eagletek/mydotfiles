# Reset
Color_Off='[0m'       # Text Reset
Bg_Reset='[49m'
Fg_Reset='[39m'

# Modifiers -- e.g. bold-red would be ${Bold}${Red} or shortcut ${BRed}
# note: modifiers can be combined -- e.g. ${Bold}${Underline}${Red}
Bold='[1m'
Underline='[4m'
Blink='[5m'  ## doesn't seem to work
Reverse='[7m'
Conceal='[8m'

# Regular Colors
Black='[30m'        # Black
Red='[31m'          # Red
Green='[32m'        # Green
Yellow='[33m'       # Yellow
Blue='[34m'         # Blue
Purple='[35m'       # Purple
Cyan='[36m'         # Cyan
White='[37m'        # White

# Bold shortcuts
BBlack='[1;30m'       # Black
BRed='[1;31m'         # Red
BGreen='[1;32m'       # Green
BYellow='[1;33m'      # Yellow
BBlue='[1;34m'        # Blue
BPurple='[1;35m'      # Purple
BCyan='[1;36m'        # Cyan
BWhite='[1;37m'       # White

# Underline shortcuts
UBlack='[4;30m'       # Black
URed='[4;31m'         # Red
UGreen='[4;32m'       # Green
UYellow='[4;33m'      # Yellow
UBlue='[4;34m'        # Blue
UPurple='[4;35m'      # Purple
UCyan='[4;36m'        # Cyan
UWhite='[4;37m'       # White

# Background
On_Black='[40m'       # Black
On_Red='[41m'         # Red
On_Green='[42m'       # Green
On_Yellow='[43m'      # Yellow
On_Blue='[44m'        # Blue
On_Purple='[45m'      # Purple
On_Cyan='[46m'        # Cyan
On_White='[47m'       # White

# High Intensity
IBlack='[90m'       # Black
IRed='[91m'         # Red
IGreen='[92m'       # Green
IYellow='[93m'      # Yellow
IBlue='[94m'        # Blue
IPurple='[95m'      # Purple
ICyan='[96m'        # Cyan
IWhite='[97m'       # White

# Bold High Intensity shortcuts
BIBlack='[1;90m'      # Black
BIRed='[1;91m'        # Red
BIGreen='[1;92m'      # Green
BIYellow='[1;93m'     # Yellow
BIBlue='[1;94m'       # Blue
BIPurple='[1;95m'     # Purple
BICyan='[1;96m'       # Cyan
BIWhite='[1;97m'      # White

# High Intensity backgrounds
On_IBlack='[100m'   # Black
On_IRed='[101m'     # Red
On_IGreen='[102m'   # Green
On_IYellow='[103m'  # Yellow
On_IBlue='[104m'    # Blue
On_IPurple='[105m'  # Purple
On_ICyan='[106m'    # Cyan
On_IWhite='[107m'   # White



# --- 256 color mode functions --- #

# values 0-5 for each RGB color field
mkcolor() {
    red=$1
    green=$2
    blue=$3

    echo $((16 + red*36 + green*6 + blue))
}

# 0-23 grayscale steps black to white
mkgray() {
    gray=$1
    echo $((gray+=232))
}

mkfg() {
    echo "[38;5;${1}m"
}
mkbg() {
    echo "[48;5;${1}m"
}

fgcolor() {
    color=$(mkcolor $@)
    echo "[38;5;${color}m"
}
bgcolor() {
    color=$(mkcolor $@)
    echo "[48;5;${color}m"
}

# 0-23 grayscale steps black to white
fggray() {
    gray=$1
    ((gray+=232))
    echo "[38;5;${gray}m"
}

# 0-23 grayscale steps black to white
bggray() {
    gray=$1
    ((gray+=232))
    echo "[48;5;${gray}m"
}

bgreset() {
    echo "[49m"
}
fgreset() {
    echo "[39m"
}
coloroff() {
    echo "[0m"
}

showcolors() {
    for red in $(seq 0 5); do
    for green in $(seq 0 5); do
    for blue in $(seq 0 5); do
        echo -n "$(fggray 23)$(bgcolor $red $green $blue) ${red}${green}${blue} $(coloroff)"
    done
    echo -n "    "
    for blue in $(seq 0 5); do
        echo -n "$(fggray 0)$(bgcolor $red $green $blue) ${red}${green}${blue} $(coloroff)"
    done
    echo " "
    done
    done

    echo " "
    for gray in $(seq 0 23); do
        echo -n "$(fgcolor 5 0 0)$(bggray $gray) ${gray} $(coloroff)"
    done
    echo " "
}

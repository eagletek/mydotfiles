# -------
# Display
# -------
function getResolution() { xdpyinfo | awk -F'[ ()]+' '/dimensions:/{print $3, $4}'; }
function getDisplaySize() { xdpyinfo | awk -F'[ ()]+' '/dimensions:/{print $5, $6}'; }

# --------
# Accounts
# --------
function showAccount() { ypcat passwd | grep -i $*; }

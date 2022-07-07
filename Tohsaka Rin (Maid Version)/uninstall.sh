#!/bin/bash

# GRUB2 Theme

# Do not edit this file!!!!

ROOT_UID=0
THEME_DIR="/usr/share/grub/themes"
THEME_NAME="Rin-Maid-Version"

MAX_DELAY=20                                        # max delay for user to enter root password


#colors

CDEF=" \033[0m"                                     # default color
CCIN=" \033[0;36m"                                  # info color
CGSC=" \033[0;32m"                                  # success color
CRER=" \033[0;31m"                                  # error color
CWAR=" \033[0;33m"                                  # warning color
b_CDEF=" \033[1;37m"                                # bold default color
b_CCIN=" \033[1;36m"                                # bold info color
b_CGSC=" \033[1;32m"                                # bold success color
b_CRER=" \033[1;31m"                                # bold error color
b_CWAR=" \033[1;33m"  



# echo like ...  with  flag type  and display message  colors
prompt () {
  case ${1} in
    "-s"|"--success")
      echo -e "${b_CGSC}${@/-s/}${CDEF}";;          # print success message
    "-e"|"--error")
      echo -e "${b_CRER}${@/-e/}${CDEF}";;          # print error message
    "-w"|"--warning")
      echo -e "${b_CWAR}${@/-w/}${CDEF}";;          # print warning message
    "-i"|"--info")
      echo -e "${b_CCIN}${@/-i/}${CDEF}";;          # print info message
    *)
    echo -e "$@"
    ;;
  esac
}

# Welcome message
  prompt -s "\n\t        ***************************************\n\t        * Tohsaka Rin (Maid) Bootloader Theme *\n\t        ***************************************\n
                               GRUB Theme

                                   by

                            Andi Trisna Mukti \n \n"


 

# checking command availability
function has_command() {
  command -v $1 > /dev/null
}


prompt -i "Press enter to begin uninstallation${CDEF}(automatically uninstalling after 10s) ${b_CWAR}:${CDEF}"
read -t10  

#checking for root access
prompt -w "\n Checking for root access...\n"
if [ "$UID" -eq "$ROOT_UID" ]; then
  # remove theme direcory
  prompt -i "\n Deleting theme directory...\n"
  if [ -d ${THEME_DIR}/${THEME_NAME} ]; then
   rm -R ${THEME_DIR}/${THEME_NAME}
 fi

  
  # remove grub config
  cp -an /etc/default/grub /etc/default/grub.bak
  sed -i '/GRUB_THEME=/d' /etc/default/grub



  prompt -i "\n finalizing your uninstallation...\n \n."
  # Update grub config
  echo -e " Updating grub config..."
  if has_command update-grub; then
    update-grub
  elif has_command grub-mkconfig; then
    grub-mkconfig -o /boot/grub/grub.cfg
  elif has_command grub2-mkconfig; then
    if has_command zypper; then
      grub2-mkconfig -o /boot/grub2/grub.cfg
    elif has_command dnf; then
      grub2-mkconfig -o /boot/efi/EFI/fedora/grub.cfg
    fi
  fi

  # Success message
  prompt -s "\n\t            ****************************\n\t            * Successfully Uninstalled *\n\t            ****************************\n"

  

else

  # Error message
  prompt -e "\n [ Error! ] -> Run me as root  \n \n "

fi










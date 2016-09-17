
echo 'Vault integration here for root_password:'
export ROOT_PWD=`makepasswd -chars=128`
export GRUB_SEED=`makepasswd -chars=16`

export GRUB_FEED="$GRUB_SEED\n$GRUB_SEED"
echo 'Vault integration here for root_password_grub:'
export GRUB_PWD=`echo -e $GRUB_FEED | grub-mkpasswd-pbkdf2 | awk '/grub.pbkdf/{print$NF}'`

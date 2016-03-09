echo "Setting up gitolite with pubkey"

# It comparing pubkey and update repo only on change
su git -c 'USER=git gitolite setup --pubkey ~/$GITOLITE_ADMIN_NAME.pub'

echo "Setting up gitolite with pubkey"

# It comparing pubkey and update repo only on change
su gitolite -c "gitolite setup --pubkey ~/$GITOLITE_ADMIN_NAME.pub"

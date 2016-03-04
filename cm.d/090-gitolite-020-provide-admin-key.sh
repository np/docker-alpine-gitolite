if [ -f /home/git/admin.pub ]; then
  echo "Admin key exists, so nothing to do here"
  return
fi

if [ -n "$GITOLITE_ADMIN_KEY" ]; then
  echo "Admin key provided through environment and saved"
  echo "$GITOLITE_ADMIN_KEY" > /home/git/admin.pub
  return
fi

echo "No admin key provided, so it will be generated for you"
ssh-keygen -t rsa -b 2048 -f /home/git/admin -N ''

echo ""
echo "Generated admin's private key:"
cat /home/git/admin
echo ""
echo "Generated admin's public key:"
cat /home/git/admin.pub
echo ""

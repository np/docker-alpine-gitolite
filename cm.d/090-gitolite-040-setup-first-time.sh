if [ -d ./.gitolite ] ; then
  return
fi

if [ ! -d ./repositories/gitolite-admin.git ]; then
  return
fi

# Credits to miracle2k
echo "Setting up gitolite first time"

mv ./repositories/gitolite-admin.git ./repositories/gitolite-admin.git-tmp

su gitolite -c 'gitolite setup -a dummy'

if [ -d ./repositories/gitolite-admin.git-tmp ]; then
  rm -rf ./repositories/gitolite-admin.git
  mv ./repositories/gitolite-admin.git-tmp ./repositories/gitolite-admin.git
fi

su gitolite -c "cd repositories/gitolite-admin.git && GL_LIBDIR=$(gitolite query-rc GL_LIBDIR) hooks/post-update refs/heads/master"

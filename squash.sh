set -ex

now=`date '+%Y-%m-%d-%H_%M_%S'`
git fetch origin
git reset --hard origin/main
head=`git rev-parse HEAD`
git push -f git@github.com:Leo-LiHao/test_squash_commit.git $head:refs/heads/snapshot-$now

msg=$(cat <<-END
Collapse index into one commit

Previous HEAD was $head, now on the \`snapshot-$now\` branch

More information about this change can be found [online]

[online]: https://internals.rust-lang.org/t/cargos-crate-index-upcoming-squash-into-one-commit/8440
END
)

new_rev=$(git commit-tree HEAD^{tree} -m "$msg")

git push \
  git@github.com:Leo-LiHao/test_squash_commit.git \
  $new_rev:refs/heads/main \
  --force-with-lease=refs/heads/main:$head
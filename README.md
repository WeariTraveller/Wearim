## Introduction
- Self-used
- Use lazy.nvim to manage plugins
- Easy to expand

## Branches
There are two major branches: `main` and `withLazy-lock`. The only difference
between them is that the branch `main` doesn't have `lazy-lock.json` while the
other does. The reason why I chose `main` as the default branch is that I think
nvim plugins can't commit too many breaking changes so this is safe enough.
However, on the other hand, the commonly used branch and the basic branch are
still `withLazy-lock`. All feature branches have `lazy-lock.json`.

## Introduction
- Self-used
- Use lazy.nvim to manage plugins
- Easy to expand

# Develop

## Init
After cloning this repo, you need to run `npm install` or `pnpm install`, etc.
to init git hooks.

## Branches
I planned to always keep the following 2 branches on hand: `main` without `lazy
-lock.json` and `withLazy-lock` with it. But later I gave up, because I found
it a bit troublesome to do so.

<details>
<summary><del>My first plan</del></summary>

~~There are two major branches: `main` and `withLazy-lock`. The only difference
between them is that the branch `main` doesn't have `lazy-lock.json` while the
other does. The reason why I chose `main` as the default branch is that I think
nvim plugins can't commit too many breaking changes so this is safe enough.
However, on the other hand, the commonly used branch and the basic branch are
still `withLazy-lock`. All feature branches have `lazy-lock.json`.~~

</details>

# ⌨️ powershell-scripts
A set a PowerShell scripts to simplify the usage of GIT.

## 📄 Profile
The profile script is used to initialize [oh-my-posh](https://ohmyposh.dev/) and set the theme for the PowerShell prompt.
It also retrieves the main GIT branch name and sets several aliases for GIT commands.

The main branch is detected from `refs/remotes/origin/HEAD`. If it cannot be detected, `origin/main` is used.

### ⚡ GIT aliases

| Alias | Function | Command | Description |
|-------|----------|---------|-------------|
| `gh [params]` | `GitHistory` | `git log --oneline` | Shows the commit history in one-line format. Shows the last 10 commits by default. Pass `-N` to show N commits, or other `git log` arguments (limited to 10 commits). |
| `gb <branch> [commit]` | `GitBranch` | `git branch --force` | Creates or resets a branch at the current HEAD or at the given commit. |
| `gbc <branch> [commit]` | `GitBranchAndCheckout` | `git branch --force` + `git checkout` | Creates or resets a branch, then checks it out. |
| `gc <branch>` | `GitCheckout` | `git checkout` | Checks out the given branch. |
| `gr [source]` | `GitRebase` | `git rebase -i` | Starts an interactive rebase from the given source (`HEAD~10` by default). |
| `gm [source]` | `GitRebaseOnMain` | `git rebase -i <source> --onto <main>` | Starts an interactive rebase of the commits after the given source (`HEAD~10` by default) onto the main branch. |
| `gra` | `GitRebaseAbort` | `git rebase --abort` | Aborts the current rebase. |
| `grc` | `GitRebaseContinue` | `git rebase --continue` | Continues the current rebase. |
| `gp <branch>` | `GitPush` | `git push -f origin <branch>:<branch>` | Force-pushes the given branch to `origin`. |
| `gf` | `GitFetch` | `git fetch origin` | Fetches from `origin`. |
| `gs` | `GitStatus` | `git status` | Shows the working tree status. |
| `gmt` | `GitMergeTool` | `git mergetool` | Opens the configured merge tool to resolve conflicts. |

> The profile hides the PowerShell built-in `gc` and `gm` aliases for the `Get-Content` and `Get-Member` commands.
> It also hides the GitHub CLI `gh` command.

## 🛠️ Installation
All the files from the `Profile` folder should be copied to the PowerShell profile folder, which can be found at `$PROFILE`.
The `Paradox-custom.json` theme file should also be copied to the same folder.

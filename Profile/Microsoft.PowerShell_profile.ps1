# Initialize oh-my-posh
$ProfilePath = Split-Path -Path $PROFILE -Parent
$ThemePath = Join-Path -Path $ProfilePath -ChildPath "Paradox-custom.json"
oh-my-posh init pwsh --config $ThemePath  | Invoke-Expression

# Get main GIT branch name
$MainBranchFullPath = git symbolic-ref refs/remotes/origin/HEAD 2>nul
$MainBranch = ($MainBranchFullPath -split 'origin')[-1]

Write-Host "Main branch is: " -NoNewLine

if ([string]::IsNullOrEmpty($MainBranch))
{
    $MainBranch = 'origin/main'
    Write-Host -ForegroundColor Yellow $MainBranch
}
else
{
    $MainBranch = 'origin' + $MainBranch
    Write-Host -ForegroundColor Green $MainBranch
}

# Install GIT aliases
function GitHistory
{
    param(
        [string]$parameters = "-10"
    )

    if ($parameters -notmatch '-\d+')
    {
        git log --oneline -10 $parameters
    }
    else
    {
        git log --oneline $parameters
    }
}

function GitCheckout
{
    param(
        [string]$branchName
    )

    git checkout $branchName
}

function GitBranch
{
    param(
        [string]$branchName,
        [string]$commitId = ""
    )

    if ([string]::IsNullOrEmpty($commitId))
    {
        git branch --force $branchName
    }
    else
    {
        git branch --force $branchName $commitId
    }
}

function GitBranchAndCheckout
{
    param(
        [string]$branchName,
        [string]$commitId = ""
    )

    GitBranch $branchName $commitId
    GitCheckout $branchName
}

function GitRebase
{
    param(
        [string]$sourceBranchName = "HEAD~10"
    )

    git rebase -i $sourceBranchName
}

function GitRebaseOnMain
{
    param(
        [string]$sourceBranchName = "HEAD~10"
    )

    git rebase -i $sourceBranchName --onto $MainBranch
}

function GitPush
{
    param(
        [string]$branchName
    )

    git push -f origin ${branchName}:${branchName}
}

function GitFetch
{
    git fetch origin
}

function GitRebaseAbort
{
    git rebase --abort
}

function GitRebaseContinue
{
    git rebase --continue
}

function GitStatus
{
    git status
}

function GitMergeTool
{
    git mergetool
}

Set-Alias -Name gh -Value GitHistory -Force
Set-Alias -Name gb -Value GitBranch -Force
Set-Alias -Name gbc -Value GitBranchAndCheckout -Force
Set-Alias -Name gr -Value GitRebase -Force
Set-Alias -Name gm -Value GitRebaseOnMain -Force
Set-Alias -Name gp -Value GitPush -Force
Set-Alias -Name gc -Value GitCheckout -Force
Set-Alias -Name gf -Value GitFetch -Force
Set-Alias -Name gra -Value GitRebaseAbort -Force
Set-Alias -Name grc -Value GitRebaseContinue -Force
Set-Alias -Name gs -Value GitStatus -Force
Set-Alias -Name gmt -Value GitMergeTool -Force

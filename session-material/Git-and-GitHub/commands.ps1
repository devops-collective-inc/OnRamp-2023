winget show git

winget show Git.Git

winget install --id Git.Git -e --source winget


git config --list 
git config --list --system
git config --list --global
git config --list --local

git config --global user.email "kevmar@gmail.com"
git config --global user.name "Kevin Marquette"

git config --list --global

# Set VSCode as default editor
git config --global core.editor "code --wait"
git config --list --global

# edit config in VSCode
git config --global --edit

# VSCode as diff tool
git config --global diff.tool "default-difftool"
git config --global difftool.default-difftool.cmd 'code --wait --diff $LOCAL $REMOTE'

```
[diff]
    tool = default-difftool
[difftool "default-difftool"]
    cmd = code --wait --diff $LOCAL $REMOTE
```


core.editor="C:\Users\kevma\AppData\Local\Programs\Microsoft VS Code\bin\code" --wait
user.email=kevmar@gmail.com
user.name=Kevin Marquette



git clone https://github.com/KevinMarquette/CodeGolfPresentation.git
cd .\CodeGolfPresentation\
ls
git status

ls
Set-Content README.md -value "Placeholder File"
ls
git status
git add .\README.md
git status
git commit -m "add readme"
<#

Author identity unknown

*** Please tell me who you are.

Run

  git config --global user.email "kevmar@gmail.com"
  git config --global user.name "Kevin Marquette"

to set your account's default identity.
Omit --global to set the identity only in this repository.
#>
# Set user and email for single  project
git init
git config user.name "Gaohong Wei"
git config user.name
git config user.email "gaohongwei@gmail.com"
git config user.email

# Set user and email globally
git init
git config --global user.name "Gaohong Wei"
git config --global user.name
git config --global user.email "gaohongwei@gmail.com"
git config --global user.email

### .git/config
[core]
        repositoryformatversion = 0
        filemode = true
        bare = false
        logallrefupdates = true
        ignorecase = true
        precomposeunicode = true
[remote "origin"]
        url = https://gaohongwei@github.com/gaohongwei/rails_topics.git
        fetch = +refs/heads/*:refs/remotes/origin/*
[branch "master"]
        remote = origin
        merge = refs/heads/master
[user]
        email = gaohongwei@gmail.com
        name = gaohong wei
        username = abc

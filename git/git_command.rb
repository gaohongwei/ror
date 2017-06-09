
ssh-keygen -t rsa
ssh-copy-id remote_host
ssh -p port_number remote_host
ssh remote_host command_to_run

Testing your SSH connection
ssh -T git@github.com

git push origin master --usernamessh -p port_number remote_host
ssh remote_host command_to_run


git clone https://gaohongwei@github.com/gaohongwei/rails_topics

Checkout specific files from another branch
git checkout development -- Gemfile
git checkout development -- Gemfile.lock


##### Create repo #####
https://www.youtube.com/watch?v=UeAjrcIVYQA
歡樂頌 【衛視版】第37集（劉濤、蔣欣、王凱、靳東等主演）

1. Generate an SSH key
cd ~                 #Your home directory
ssh-keygen -t rsa    #Press enter for all values

2. Copy the key
pbcopy < ~/.ssh/id_rsa.pub

3. Associate the SSH key with the remote repository
GO a GitHub repository
Go to settings
Click 'add SSH key'



echo "# abc" >> README.md
git init
git add README.md
git commit -m "first commit"
git remote add origin https://github.com/gaohongwei/abc.git
git push -u origin master


$ git remote -v
origin  https://github.com/gaohongwei/abc.git (fetch)
origin  https://github.com/gaohongwei/abc.git (push)
$ git remote set-url origin git@github.com:gaohongwei/abc.git
$ git remote -v
origin  git@github.com:gaohongwei/abc.git (fetch)
origin  git@github.com:gaohongwei/abc.git (push)

######## Use 2nd account ########
ssh -T git@github.com
eval "$(ssh-agent -s)"
ssh-add -K ~/.ssh/gwei_rsa
ssh -T git@github.com
ssh-add -l
git config user.name gwei
git config user.email gaohongwei@gmail.com

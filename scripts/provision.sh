#!/usr/bin/env bash

set -eu

export "LANG=en_US.UTF-8"
export HOMEBREW_NO_AUTO_UPDATE=1
export HOMEBREW_NO_INSTALL_CLEANUP=1

# Allow sudo without password
echo ${account.password} | sudo -S sh -c "mkdir -p /etc/sudoers.d/"
echo ${account.password} | sudo -S sh -c "echo '${account.username} ALL=(ALL) NOPASSWD: ALL' | EDITOR=tee visudo /etc/sudoers.d/${account.username}"

# Install command line tools
touch /tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress
softwareupdate --list | sed -n 's/.*Label: \(Command Line Tools for Xcode-.*\)/\1/p' | xargs -I {} softwareupdate --install '{}'
rm /tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress

# Enable autologin
sudo defaults write /Library/Preferences/com.apple.loginwindow autoLoginUser ${account.username}
sudo defaults write /Library/Preferences/com.apple.screensaver loginWindowIdleTime 0

sudo python3 ~/kc-passwd.py ${account.password}
rm -rf ~/kc-passwd.py

# Disable screensaver
defaults -currentHost write com.apple.screensaver idleTime 0

# Disable sleep
sudo systemsetup -setsleep Off 2>/dev/null

# Disable screen lock
sysadminctl -screenLock off -password ${account.password}

spctl --status | grep -q 'assessments disabled'

# Disabling spotlight"
sudo mdutil -a -i off

# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

/opt/homebrew/bin/brew shellenv > ~/.zprofile
source ~/.zprofile

/opt/homebrew/bin/brew update
/opt/homebrew/bin/brew install git git-lfs zsh
/opt/homebrew/bin/brew install xcodesorg/made/xcodes
/opt/homebrew/bin/brew install ${join(" ", install.brew.packages)}
/opt/homebrew/bin/brew install --cask ${join(" ", install.brew.casks)}

# Enable Git LFS
git lfs install

# Install Xcode
%{ for x in install.xcode ~}
xcodes install ${x.version} --experimental-unxip --path ~/Xcode-${x.version}.xip --empty-trash %{if x.select} --select %{endif}
%{ endfor ~}

# Install Guest Agent
/opt/homebrew/bin/brew install cirruslabs/cli/tart-guest-agent

cat << EOF | sudo tee -a /Library/LaunchAgents/org.cirruslabs.tart-guest-agent.plist
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
    <dict>
        <key>Label</key>
        <string>org.cirruslabs.tart-guest-agent</string>
        <key>ProgramArguments</key>
        <array>
            <string>/opt/homebrew/bin/tart-guest-agent</string>
            <string>--run-agent</string>
        </array>
        <key>EnvironmentVariables</key>
        <dict>
            <key>PATH</key>
            <string>/bin:/usr/bin:/usr/sbin:/usr/local/bin:/opt/homebrew/bin</string>
            <key>TERM</key>
            <string>xterm-256color</string>
        </dict>
        <key>WorkingDirectory</key>
        <string>/Users/admin</string>
        <key>RunAtLoad</key>
        <true/>
        <key>KeepAlive</key>
        <true/>
        <key>StandardOutPath</key>
        <string>/tmp/tart-guest-agent.log</string>
        <key>StandardErrorPath</key>
        <string>/tmp/tart-guest-agent.log</string>
    </dict>
</plist>
EOF

cat << EOF | sudo tee -a /Library/LaunchDaemons/org.cirruslabs.tart-guest-daemon.plist
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
    <dict>
        <key>Label</key>
        <string>org.cirruslabs.tart-guest-daemon</string>
        <key>ProgramArguments</key>
        <array>
            <string>/opt/homebrew/bin/tart-guest-agent</string>
            <string>--run-daemon</string>
        </array>
        <key>EnvironmentVariables</key>
        <dict>
            <key>PATH</key>
            <string>/bin:/usr/bin:/usr/sbin:/usr/local/bin:/opt/homebrew/bin</string>
        </dict>
        <key>WorkingDirectory</key>
        <string>/var/empty</string>
        <key>RunAtLoad</key>
        <true/>
        <key>KeepAlive</key>
        <true/>
        <key>StandardOutPath</key>
        <string>/tmp/tart-guest-daemon.log</string>
        <key>StandardErrorPath</key>
        <string>/tmp/tart-guest-daemon.log</string>
    </dict>
</plist>
EOF

cat << EOF | sudo tee -a /Library/LaunchDaemons/limit.maxfiles.plist
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
  <dict>
    <key>Label</key>
    <string>limit.maxfiles</string>
    <key>ProgramArguments</key>
    <array>
      <string>launchctl</string>
      <string>limit</string>
      <string>maxfiles</string>
      <string>65536</string>
      <string>524288</string>
    </array>
    <key>RunAtLoad</key>
    <true/>
    <key>ServiceIPC</key>
    <false/>
  </dict>
</plist>
EOF

sudo chown root:wheel /Library/LaunchAgents/org.cirruslabs.tart-guest-agent.plist
sudo chown root:wheel /Library/LaunchDaemons/org.cirruslabs.tart-guest-daemon.plist
sudo chown root:wheel /Library/LaunchDaemons/limit.maxfiles.plist

sudo chmod 0644 /Library/LaunchAgents/org.cirruslabs.tart-guest-agent.plist
sudo chmod 0644 /Library/LaunchDaemons/org.cirruslabs.tart-guest-daemon.plist
sudo chmod 0644 /Library/LaunchDaemons/limit.maxfiles.plist

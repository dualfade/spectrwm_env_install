#!/usr/bin/env ruby
# spectrwm_env_install.rb
# dualfade --

# spectrwm environment installer --
# python re-rewrite in ruby, however we are tailored for
# spectrwm installation --
# this also assumes you have net-installed archlinux only.
# bare-bones install in essence.

# WARN: README !
# install the requirements below first --
# sudo pacman -Syu ruby zsh git

# require gems --
require 'bundler/inline'

gemfile do
  source 'https://rubygems.org'
  gem 'open3', require: true
  gem 'slop', require: true
  gem 'logger', require: true
end

# logging --
logger = Logger.new($stdout)
original_formatter = Logger::Formatter.new
logger.formatter = proc { |severity, datetime, progname, msg|
  original_formatter.call(severity, datetime, progname, msg.dump)
}

# Github directory struct --
# if it's not a blackarch package; we organize here --
def github_dir_struct
  # inspired by ptf --
  # https://github.com/trustedsec/ptf --
  git_dir_struct = %w[av-bypass code-audit custom_list exploitation intelligence-gathering mobile-analysis
                      osx password-recovery pivoting post-exploitation powershell pre-engagement reporting
                      reversing threat-modeling vulnerability-analysis webshells windows-tools wireless
                      miscellaneous]

  git_dir_struct.each do |i|
    # iterate array; create directory struct --
    cmd = format('/usr/bin/mkdir -p ~/Github/%s', i)
    Open3.popen3(cmd) do |_stdin, stdout, stderr, _thread|
      logger = Logger.new($stdout)
      logger.info("creating directory => #{i}")

      # check for stderr --
      stderr_check(stdout.read, stderr.read)
    end
  end
end

def install_base_packages
  # ref --
  # https://bit.ly/3AvlJHv --
  # https://bit.ly/3cvTq3w --
  logger = Logger.new($stdout)

  # update pacman.conf  --
  # enable Color output; enable ParallelDownloads --
  pac_file = '/etc/pacman.conf'
  logger.info("updating => #{pac_file}; enabling Color, ParallelDownloads = 5")
  logger.info(Open3.pipeline(["/usr/bin/sudo /usr/bin/sed -i 's/#Color/Color/g' \
    #{pac_file}"]))
  logger.info(Open3.pipeline(["/usr/bin/sudo /usr/bin/sed -i 's/#ParallelDownloads = \
    5/ParallelDownloads = 5/g' #{pac_file}"]))

  # base packages --
  base_packages = "spectrwm xorg fzf the_silver_searcher ranger neovim tmux \
    xterm alacritty alacritty-themes bmz-cursor-theme-git vimix-icon-theme \
    arc-gtk-theme neofetch"

  cmd = "/usr/bin/sudo /usr/bin/pacman -Sy #{base_packages}"
  Open3.pipeline cmd, in: $stdin, out: $stdout
  puts $stdin
  puts $stdout
end

def install_oh_my_zsh
  # install oh-my-zsh --
  logger = Logger.new($stdout)

  # WARN: check existing installation --
  # NOTE: not needed; zsh install will terminate on it's own  --
  # zsh_directory = '~/.oh-my-zsh'
  # if Dir.exist?("#{zsh_directory}")
  #   logger.error("exists => ~/#{username}/.oh-my-zsh")
  #   logger.error('exiting => manually back up your ~/.oh-my-zsh installtion')
  #   logger.error('then restart the install')
  #   exit
  # end

  logger.info('installing => oh-my-zsh')
  logger.info('url => https://ohmyz.sh/#install')
  cmd = 'sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"'
  Open3.pipeline cmd, in: $stdin, out: $stdout
  puts $stdin
  puts $stdout

  # zsh plugins --
  zsh_auto = 'git clone https://github.com/zsh-users/zsh-autosuggestions.git \
    ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions'
  zsh_syntax = 'git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
    ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting'

  # init --
  zsh_plugins = %w[]
  zsh_plugins.push(zsh_auto, zsh_syntax)
  zsh_plugins.each do |i|
    Open3.pipeline i, in: $stdin, out: $stdout
    puts $stdin
    puts $stdout
  end
end

def install_config_files
  # placeholder --
end

def install_blackarch_pacstrap
  # enable blackarch repo --
  # https://blackarch.org/downloads.html --
  logger = Logger.new($stdout)
  logger.info('enablng => blackarch repositories')

  # array commands --
  ba_strap_file = '/usr/bin/curl -O https://blackarch.org/strap.sh'
  ba_sha1_checksum = '/bin/echo 5ea40d49ecd14c2e024deecf90605426db97ea0c strap.sh \
    | /usr/bin/sha1sum -c'
  ba_set_perms = '/usr/bin/chmod +x strap.sh'
  ba_run_sudo = '/usr/bin/sudo ./strap.sh'
  ba_pacman_update = '/usr/bin/sudo pacman -Syu'

  ba_pacstrap = %w[]
  ba_pacstrap.push(ba_strap_file, ba_sha1_checksum, ba_set_perms, \
                   ba_run_sudo, ba_pacman_update)

  ba_pacstrap.each do |i|
    Open3.pipeline i, in: $stdin, out: $stdout
    puts $stdin
    puts $stdout
  end
end

def post_install
  # placeholder --
  # clear pacman cache --
end

def stderr_check(stdout, stderr)
  # initialize --
  logger = Logger.new($stdout)

  return unless stderr == 1

  logger.error(stdout.read)
  logger.info(stderr.read) if stdout == 1
end

# errors --
def error(message)
  # logger; new instance obj --
  logger = Logger.new($stdout)
  logger.info(format('%s', message))
end

# main --
if __FILE__ == $PROGRAM_NAME
  # get opts; check for missing params --
  # send to logger --
  logger.info('starting installer --')
  begin
    opts = Slop.parse do |o|
      o.String('-u', '--username', 'install with username: ex: dualfade')
      o.bool('-i', '--install', 'run the installer')
      o.on('-h', '--help', 'this menu') do
        puts(o)
        puts("\nex: ruby env_installer.rb -u dualfade --install")
        exit
      end
    end

    # error check; stdout --
    exit logger.error('exit => missing username') if opts[:username].nil?
    exit logger.error('exit => missing install') if opts[:install].nil?

    # opts -> hash --
    username = (opts[:username])
    supplied_uid = Process::UID.from_name("#{username}")
    logger.info("current uid => #{supplied_uid}")

    # check user uid --
    if Process.uid == supplied_uid
      logger.info("starting installation for user => #{username}")
    else
      logger.error("#{username} => invalid install user")
      exit
    end

    # defs --
    github_dir_struct
    install_base_packages
    install_blackarch_pacstrap
    install_oh_my_zsh
  rescue Slop::Error => e
    logger.error(e)
  rescue StandardError => e
    logger.error(e)
  end
end

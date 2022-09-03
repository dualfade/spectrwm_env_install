#!/usr/bin/env ruby
# spectrwm_env_install.rb
# dualfade --

# spectrwm environment installer --
# python re-rewrite in ruby, however we are tailored for
# spectrwm installation --
# this also assumes you have net-installed archlinux only.
# bare-bones install in essence.

# WARN: README !
# install the requirements below first; and reboot if required --
# sudo pacman -Syu ruby zsh git
# /sbin/sudo sync -f && /sbin/sudo /sbin/shutdown now -r
# restart the installer --

# require gems --
require 'bundler/inline'

gemfile do
  source 'https://rubygems.org'
  gem 'open3', require: true
  gem 'slop', require: true
  gem 'logger', require: true
  gem 'nokogiri', require: true
  gem 'open-uri', require: true
end

# logging --
logger = Logger.new($stdout)
original_formatter = Logger::Formatter.new
logger.formatter = proc { |severity, datetime, progname, msg|
  original_formatter.call(severity, datetime, progname, msg.dump)
}

# class --
class InstallClass
  # rinse and repeat --
  logger = Logger.new($stdout)
  logger.info('init => class installation')

  def pacman_installer(packages)
    cmd = "/usr/bin/sudo /usr/bin/pacman -Sy #{packages}"
    Open3.pipeline cmd, in: $stdin, out: $stdout

    # stderr check --
    stderr_check($stdin, $stdout)
  end

  def yay_installer(packages)
    cmd = "/usr/bin/yay -Sy #{packages}"
    Open3.pipeline cmd, in: $stdin, out: $stdout

    # stderr check --
    stderr_check($stdin, $stdout)
  end
end

# defs --
def github_dir_struct
  # inspired by ptf --
  # https://github.com/trustedsec/ptf --
  # Github directory struct --
  # if it's not a blackarch package; we organize here --
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
    xterm alacritty fakeroot base-devel"

  to_install = InstallClass.new
  to_install.pacman_installer(base_packages)
end

def install_oh_my_zsh
  # install oh-my-zsh --
  logger = Logger.new($stdout)

  logger.info('installing => oh-my-zsh')
  logger.info('url => https://ohmyz.sh/#install')
  cmd = 'sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"'
  Open3.pipeline cmd, in: $stdin, out: $stdout
  stderr_check($stdin, $stdout)

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
    stderr_check($stdin, $stdout)
  end
end

def install_config_files
  # TODO: placeholder --
end

def install_pacstrap
  # enable blackarch repo --
  # https://blackarch.org/downloads.html --
  logger = Logger.new($stdout)
  logger.info('enablng => blackarch repositories')

  # fetch sha1sum cmd --
  # we do not want to keep modifying this for a changing checksum --
  page = Nokogiri::HTML(URI.open('https://blackarch.org/downloads.html'))
  ba_sha1_checksum = page.xpath('/html/body/div/div[2]/div[2]/div[3]/ul/li/div[1]/span[2]').text

  # array commands --
  ba_strap_file = '/usr/bin/curl https://blackarch.org/strap.sh -o ${PWD}/strap.sh'
  ba_set_perms = '/usr/bin/chmod +x strap.sh'
  ba_run_sudo = '/usr/bin/sudo ./strap.sh'
  ba_pacman_update = '/usr/bin/sudo pacman -Syu'

  ba_pacstrap = %w[]
  ba_pacstrap.push(ba_strap_file, ba_sha1_checksum, ba_set_perms, \
                   ba_run_sudo, ba_pacman_update)

  ba_pacstrap.each do |i|
    Open3.pipeline i, in: $stdin, out: $stdout
    stderr_check($stdin, $stdout)
  end
end

def install_yay
  # install yay package manager; other packages --
  # clear pacman cache --
  logger = Logger.new($stdout)
  logger.info('install => yay')
  logger.info('note => add your custom apps to the array')

  # first things first; install yay --
  to_install = InstallClass.new
  to_install.pacman_installer('yay')

  # update yay; rebuild db --
  cmd = '/usr/bin/yay -Syu'
  Open3.pipeline cmd, in: $stdin, out: $stdout
  stderr_check($stdin, $stdout)

  # next; yay package array --
  # install apps --
  logger.info('yay => install packages')
  install_yay_packages = "alacritty-themes bmz-cursor-theme-git vimix-icon-theme \
    arc-gtk-theme neofetch ly"

  to_install = InstallClass.new
  to_install.yay_installer(install_yay_packages)
end

def install_ly_service
  # https://github.com/fairyglade/ly --
  # enable ly.service; disable getty@tty2.service --
  # we still want multi ttys --
  logger.info('enable => ly login manager')
  ly_service = '/usr/bin/sudo /usr/bin/systemctl enable ly.service'
  Open3.pipeline ly_service, in: $stdin, out: $stdout
  stderr_check($stdin, $stdout)

  ly_getty = '/usr/bin/sudo /usr/bin/systemctl disable getty@tty2.service'
  Open3.pipeline ly_getty, in: $stdin, out: $stdout
  stderr_check($stdin, $stdout)
  logger.info('services => done')
end

def stderr_check(stdout, stderr)
  # initialize --
  logger = Logger.new($stdout)

  # errors ?
  # what happpned; spit it out --
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
    install_pacstrap
    install_yay
    install_ly_service
    install_oh_my_zsh
  rescue Slop::Error => e
    logger.error(e)
  rescue StandardError => e
    logger.error(e)
  end
end

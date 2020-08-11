require "mkmf"

def missing!(lib)
  if RUBY_PLATFORM =~ /mingw|mswin/
    abort "-----\n#{lib} is missing. Check your installation of OpenCC, and try again.\n-----"
  elsif RUBY_PLATFORM =~ /darwin/
    abort "-----\n#{lib} is missing. You may need to 'brew install opencc', and try again.\n-----"
  else
    abort "-----\n#{lib} is missing. You may need to 'sudo apt-get install libopencc-dev', 'sudo pacman -Sy opencc' or 'sudo yum install opencc-devel' and try again.\n-----"
  end
end

missing!('opencc')   if !have_library('opencc')
missing!('opencc.h') if !have_header('opencc.h')

have_func 'opencc_open'
have_func 'opencc_convert_utf8'
have_func 'opencc_convert_utf8_free'
have_func 'opencc_close'

create_makefile 'opencc/opencc'

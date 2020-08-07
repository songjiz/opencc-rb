require "mkmf"

dir_config 'opencc'

if find_header('opencc.h') && find_library('opencc', nil)
  have_func 'opencc_open'
  have_func 'opencc_convert_utf8'
  have_func 'opencc_convert_utf8_free'
  have_func 'opencc_close'
else
  abort "*** You don't have OpenCC installed in you system. Please install from https://github.com/BYVoid/OpenCC ***"
end

create_makefile("opencc/opencc")

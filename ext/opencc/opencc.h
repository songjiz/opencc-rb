#ifndef RUBY_OPENCC_H
#define RUBY_OPENCC_H 1

#include <ruby.h>
#include <opencc/opencc.h>

static VALUE rb_opencc_open(VALUE self, VALUE rb_cfg);
static VALUE rb_opencc_convert_utf8(VALUE self, VALUE rb_ocid, VALUE rb_str);
static VALUE rb_opencc_close(VALUE self, VALUE rb_ocid);

#endif /* RUBY_OPENCC_H */

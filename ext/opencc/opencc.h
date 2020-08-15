#ifndef RUBY_OPENCC_H
#define RUBY_OPENCC_H 1

#include <ruby.h>
#include <opencc/opencc.h>

static VALUE rb_opencc_open(VALUE self, VALUE rb_cfg);
static VALUE rb_opencc_convert(VALUE self, VALUE rb_occid, VALUE rb_str);
static VALUE rb_opencc_close(VALUE self, VALUE rb_occid);

#endif /* RUBY_OPENCC_H */

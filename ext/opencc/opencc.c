#include "opencc.h"

VALUE rb_mOpenCC;

static VALUE rb_opencc_open(VALUE self, VALUE rb_cfg)
{
  const char *cfg = OPENCC_DEFAULT_CONFIG_SIMP_TO_TRAD;
  opencc_t ptr;

  if (TYPE(rb_cfg) == T_STRING && RSTRING_LEN(rb_cfg) > 0)
  {
    cfg = RSTRING_PTR(rb_cfg);
  }

  ptr = opencc_open(cfg);

  if (ptr == (opencc_t)-1)
  {
    return Qnil;
  }
  else
  {
    return LONG2FIX(ptr);
  }
}

static VALUE rb_opencc_convert_utf8(VALUE self, VALUE rb_opencc, VALUE rb_str)
{
  opencc_t ptr = (opencc_t) FIX2LONG(rb_opencc);
  char* buff = opencc_convert_utf8(ptr, RSTRING_PTR(rb_str), RSTRING_LEN(rb_str));
  return rb_str_new2(buff);
}

static VALUE rb_opencc_convert_utf8_free(VALUE self, VALUE rb_str)
{
  char *ptr = RSTRING_PTR(rb_str);
  opencc_convert_utf8_free(ptr);
  return Qnil;
}

static VALUE rb_opencc_close(VALUE self, VALUE rb_opencc)
{
  opencc_t ptr = (opencc_t) FIX2LONG(rb_opencc);

  if (opencc_close(ptr) == 0)
  {
    return Qtrue;
  }
  else
  {
    return Qfalse;
  }
}

void Init_opencc(void)
{
  rb_mOpenCC = rb_define_module("OpenCC");

  rb_define_private_method(rb_mOpenCC, "opencc_open", rb_opencc_open, 1);
  rb_define_private_method(rb_mOpenCC, "opencc_close", rb_opencc_close, 1);
  rb_define_private_method(rb_mOpenCC, "opencc_convert", rb_opencc_convert_utf8, 2);
  rb_define_private_method(rb_mOpenCC, "opencc_free", rb_opencc_convert_utf8_free, 1);
}

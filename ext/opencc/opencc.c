#include "opencc.h"

VALUE rb_mOpenCC;
VALUE rb_mOpenCC_Context;

static VALUE rb_opencc_open(VALUE self, VALUE rb_cfg)
{
  const char *cfg = OPENCC_DEFAULT_CONFIG_SIMP_TO_TRAD;
  opencc_t ptr;

  if (TYPE(rb_cfg) == T_STRING && RSTRING_LEN(rb_cfg) > 0)
  {
    cfg = RSTRING_PTR(rb_cfg);
  }

  ptr = opencc_open(cfg);

  // On error the return value will be (opencc_t) -1.
  if (ptr == (opencc_t)-1)
  {
    return Qnil;
  }
  else
  {
    return LONG2FIX(ptr);
  }
}

static VALUE rb_opencc_convert_utf8(VALUE self, VALUE rc_occid, VALUE rb_str)
{
  opencc_t ptr = (opencc_t) FIX2LONG(rc_occid);
  char * buff = opencc_convert_utf8(ptr, RSTRING_PTR(rb_str), RSTRING_LEN(rb_str));
  VALUE conveted = rb_utf8_str_new_cstr(buff);
  opencc_convert_utf8_free(buff);
  return conveted;
}

static VALUE rb_opencc_close(VALUE self, VALUE rc_occid)
{
  opencc_t ptr = (opencc_t) FIX2LONG(rc_occid);

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
  rb_mOpenCC_Context = rb_define_module_under(rb_mOpenCC, "Context");

  rb_define_private_method(rb_mOpenCC_Context, "opencc_open", rb_opencc_open, 1);
  rb_define_private_method(rb_mOpenCC_Context, "opencc_close", rb_opencc_close, 1);
  rb_define_private_method(rb_mOpenCC_Context, "opencc_convert", rb_opencc_convert_utf8, 2);
}

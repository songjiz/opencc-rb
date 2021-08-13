#include "opencc.h"

#define OPENCC_DEFAULT_CONFIG_SIMP_TO_TRAD "s2t.json"

VALUE mOpenCC;
VALUE cConverter;

typedef struct {
  opencc_t opencc;
} opencc_converter_t;

static void opencc_converter_t_dfree(void* _ptr) {
  opencc_converter_t* ptr = (opencc_converter_t*)_ptr;
  if (ptr->opencc != NULL && ptr->opencc != (opencc_t) - 1) {
    opencc_close(ptr->opencc);
  }
  free(ptr);
}

static size_t opencc_converter_t_dsize(const void* _ptr) {
  return sizeof(opencc_converter_t);
}

static const rb_data_type_t opencc_converter_data_type = {
  .wrap_struct_name = "opencc converter object",
  .function = {
    .dfree = opencc_converter_t_dfree,
    .dsize = opencc_converter_t_dsize,
  },
  .flags = RUBY_TYPED_FREE_IMMEDIATELY,
};

VALUE opencc_converter_t_alloc(VALUE self) {
  opencc_converter_t *ptr = malloc(sizeof(opencc_converter_t));

  return TypedData_Wrap_Struct(self, &opencc_converter_data_type, ptr);
}

static VALUE opencc_converter_t_initialize(int argc, VALUE* argv, VALUE self) {
  opencc_converter_t *ptr;
  const char *cfg = NULL;

  if (argv[0] != Qnil) {
    switch (TYPE(argv[0])) {
      case T_SYMBOL:
        cfg = RSTRING_PTR(rb_sym_to_s(argv[0]));
        break;
      case T_STRING:
        cfg = RSTRING_PTR(argv[0]);
        break;
    }
  }

  TypedData_Get_Struct(self, opencc_converter_t, &opencc_converter_data_type, ptr);

  ptr->opencc = opencc_open(cfg);

  // On error the return value will be (opencc_t) -1.
  if (ptr->opencc == (opencc_t) - 1) {
    free(ptr);
    rb_raise(rb_eException, "%s", "(opencc_open) failed to allocate instance of opencc");
  }
  return self;
}

static VALUE opencc_converter_t_convert(VALUE self, VALUE input) {
  opencc_converter_t *ptr;
  TypedData_Get_Struct(self, opencc_converter_t, &opencc_converter_data_type, ptr);

  if (ptr->opencc != NULL) {
    char * buff = opencc_convert_utf8(ptr->opencc, RSTRING_PTR(input), RSTRING_LEN(input));
    VALUE result = rb_utf8_str_new_cstr(buff);
    opencc_convert_utf8_free(buff);
    return result;
  } else {
    rb_warn("%s", "opencc has been closed");
    return Qnil;
  }
}

static VALUE opencc_converter_t_close(VALUE self) {
  opencc_converter_t *ptr;
  TypedData_Get_Struct(self, opencc_converter_t, &opencc_converter_data_type, ptr);

  if (ptr->opencc != NULL && opencc_close(ptr->opencc) == 0) {
    ptr->opencc = NULL;
    return Qtrue;
  } else {
    return Qfalse;
  }
}

void Init_opencc(void) {
  mOpenCC = rb_define_module("OpenCC");
  cConverter = rb_define_class_under(mOpenCC, "Converter", rb_cObject);

  rb_define_alloc_func(cConverter, opencc_converter_t_alloc);
  rb_define_method(cConverter, "initialize", opencc_converter_t_initialize, -1);
  rb_define_method(cConverter, "convert", opencc_converter_t_convert, 1);
  rb_define_method(cConverter, "close", opencc_converter_t_close, 0);
}

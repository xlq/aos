#define atspre_idx_char(a,b) (((char *) (a))[(b)])

static inline int strlen (void *sp)
{
  const char *s = sp;
  int len = 0;
  while (*s++) ++len;
  return len;
}

#define atspre_idx_char(a,b) (((char *) (a))[(b)])

static inline int strlen (const char *s)
{
  int len = 0;
  while (*s++) ++len;
  return len;
}

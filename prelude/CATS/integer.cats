#define atspre_add(a,b) ((a)+(b))
#define atspre_sub(a,b) ((a)-(b))
#define atspre_mul(a,b) ((a)*(b))
#define atspre_div(a,b) ((a)/(b))
#define atspre_mod(a,b) ((a)%(b))
#define atspre_lt(a,b) ((a)<(b))
#define atspre_gt(a,b) ((a)>(b))
#define atspre_le(a,b) ((a)<=(b))
#define atspre_ge(a,b) ((a)>=(b))
#define atspre_eq(a,b) ((a)==(b))
#define atspre_ne(a,b) ((a)!=(b))
#define atspre_shl(a,b) ((a)<<(b))
#define atspre_shr(a,b) ((a)>>(b))
#define atspre_land(a,b) ((a)&(b))
#define atspre_lor(a,b) ((a)|(b))
#define atspre_not(a) (!(a))

static inline bool atspre_premul_int1_int1 (int a, int b)
{
  long r = a;
  int rtrunc;
  r *= b;
  rtrunc = r;
  return r == rtrunc;
}
  

%{$

typedef unsigned char byte ;

//
// HX-2010-05-24
// In case 'memcpy' is already defined as a macro ...
//
#ifndef memcpy
extern void *memcpy (void *dst, const void* src, size_t n) ;
#endif // end of [memcpy]

ats_void_type
atspre_array_ptr_initialize_elt_tsz (
  ats_ptr_type A
, ats_size_type asz
, ats_ptr_type ini
, ats_size_type tsz
)  {
  int i, itsz ; int left ; ats_ptr_type p ;
  if (asz == 0) return ;
  memcpy (A, ini, tsz) ;
  i = 1 ; itsz = tsz ; left = asz - i ;
  while (left > 0) {
    p = (ats_ptr_type)(((byte*)A) + itsz) ;
    if (left <= i) { memcpy (p, A, left * tsz) ; return ; }
    memcpy (p, A, itsz);
    i = i + i ; itsz = itsz + itsz ; left = asz - i ;
  } /* end of [while] */
  return ;
} /* end of [atspre_array_ptr_initialize_elt_tsz] */

%} // end of [%{$]


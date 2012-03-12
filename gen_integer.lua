function g(s, ...)
  io.write(string.format(s, ...))
end

function indexed(t)
  return t .. "1"
end

function mbindexed(i,t)
  return i and indexed(t) or t
end

function sort(s)
  return s:sub(1,1):upper() .. s:sub(2,#s)
end

function max(t)
  return ({
    byte = "CHAR_MAX",
    ubyte = "UCHAR_MAX",
    short = "SHRT_MAX",
    ushort = "USHRT_MAX",
    int = "INT_MAX",
    uint = "UINT_MAX",
    long = "LONG_MAX",
    ulong = "ULONG_MAX",
    llong = "LLONG_MAX",
    ullong = "ULLONG_MAX"
  })[t]
end

function min(t)
  return ({
    byte = "CHAR_MIN",
    ubyte = "UCHAR_MIN",
    short = "SHRT_MIN",
    ushort = "USHRT_MIN",
    int = "INT_MIN",
    uint = "UINT_MIN",
    long = "LONG_MIN",
    ulong = "ULONG_MIN",
    llong = "LLONG_MIN",
    ullong = "ULLONG_MIN"
  })[t]
end

function unsigned(t)
  return ({
    ubyte = true,
    ushort = true,
    uint = true,
    ulong = true,
    ullong = true
  })[t]
end

types = {"byte", "short", "int", "long", "llong",
         "ubyte", "ushort", "uint", "ulong", "ullong"}

g [[
// Generated from gen_integer.lua
staload "prelude/limits.sats"

symintr imul2
infixl ( / ) udiv2 umod2
symintr udiv2 umod2
symintr ushl ushr

(**********  CONVERSION  **********)

]]

for _, t1 in ipairs(types) do
  for _, t2 in ipairs(types) do
    if t1 == t2 then
      local t = t1
      g("castfn %s_of_%s (x: %s):<> [x: %s] %s x ; ",
        indexed(t), t, t, sort(t), t)
      g("overload %s_of with %s_of_%s\n",
        indexed(t), indexed(t), t)
      g("castfn %s_of_%s {x: %s} (x: %s x):<> %s ; ",
        t, indexed(t), sort(t), t, t)
      g("overload %s_of with %s_of_%s\n",
        t, t, indexed(t))
    else
      for _, i2 in ipairs{false, true} do
        g("castfn %s_of_%s ",
          i2 and indexed(t2) or t2,
          indexed(t1))
        g("{x: %s} (x: %s x)", sort(t2), t1)
        if i2 then
          g(":<> %s x", t2)
        else
          g(":<> %s", t2)
        end
        g(" ; overload %s_of with %s_of_%s\n",
          i2 and indexed(t2) or t2,
          i2 and indexed(t2) or t2,
          indexed(t1))
      end
    end
  end
end

g [[

(**********  OPERATORS  **********)

]]

compare_ops = {
  {"eq", "=", "=="},
  {"ne", "!=", "<>"},
  {"lt", "<", "<"},
  {"gt", ">", ">"},
  {"le", "<=", "<="},
  {"ge", ">=", ">="}
}

for _, t1 in ipairs(types) do
  for _, t2 in ipairs(types) do
    for _, i1 in ipairs{false, true} do
      for _, i2 in ipairs{false, true} do
        -- comparison
        if t1 == t2 then
          for _, op in ipairs(compare_ops) do
            local op, sym, staop = unpack(op)

            g("fun %s_%s_%s ",
              op, mbindexed(i1,t1), mbindexed(i2,t2))
            if i1 then g("{a: %s} ", sort(t1)); end
            if i2 then g("{b: %s} ", sort(t2)); end
            g("(a: %s%s, b: %s%s):<> ",
              t1, i1 and " a" or "",
              t2, i2 and " b" or "")
            if i1 and i2 then g("bool (a %s b)", staop)
            else g("bool"); end
            g(" = \"mac#atspre_%s\" ; ", op)
            g("overload %s with %s_%s_%s\n",
              sym, op, mbindexed(i1,t1), mbindexed(i2,t2))
          end
        end

        if i1 and i2 and t1 == t2 then
          t = t1
          suffix = indexed(t) .. "_" .. indexed(t)
          -- ADDITION --
          g("fun add_%s {a, b: %s | a + b >= %s && a + b <= %s} ",
            suffix, sort(t), min(t), max(t))
          g("(a: %s a, b: %s b):<> %s (a+b) = \"mac#atspre_add\" ; ",
            t, t, t)
          g("overload + with add_%s\n", suffix)
          -- SUBTRACTION --
          g("fun sub_%s {a, b: %s | a - b >= %s && a - b <= %s} ",
            suffix, sort(t), min(t), max(t))
          g("(a: %s a, b: %s b):<> %s (a-b) = \"mac#atspre_sub\" ; ",
            t, t, t)
          g("overload - with sub_%s\n", suffix)
          -- MULTIPLICATION --
          g("fun premul_%s {a, b: %s} ", suffix, sort(t))
          g("(a: %s a, b: %s b):<> bool (a*b >= %s && a*b <= %s)",
            t, t, min(t), max(t))
          g(" = \"atspre_premul_%s\" ; ", suffix)
          g("overload *? with premul_%s\n", suffix)

          g("fun mul_%s {a, b: %s | a*b >= %s && a*b <= %s} ",
            suffix, sort(t), min(t), max(t));
          g("(a: %s a, b: %s b):<> %s (a*b)", t, t, t)
          g(" = \"mac#atspre_mul\" ; ")
          g("overload * with mul_%s\n", suffix)

          g("fun imul2_%s {a, b: %s | a*b >= %s && a*b <= %s} ",
            suffix, sort(t), min(t), max(t));
          g("(a: %s a, b: %s b):<> (MUL (a, b, a*b) | %s (a*b))",
            t, t, t)
          g(" = \"mac#atspre_mul\" ; ")
          g("overload imul2 with imul2_%s\n", suffix)

          if unsigned(t) then
            g("fun land_%s {a, b: %s} ", suffix, sort(t));
            g("(a: %s a, b: %s b):<> [r: %s | r <= a && r <= b] %s r", t, t, sort(t), t)
            g(" = \"mac#atspre_land\" ; ")
            g("overload land with land_%s\n", suffix)

            g("fun lor_%s {a, b: %s} ", suffix, sort(t));
            g("(a: %s a, b: %s b):<> [r: %s | r >= a && r >= b && r <= a + b] %s r", t, t, sort(t), t)
            g(" = \"mac#atspre_lor\" ; ")
            g("overload lor with lor_%s\n", suffix)

            g("fun lnot_%s {a: %s} ", indexed(t), sort(t));
            g("(a: %s a):<> [r: %s] %s r", t, sort(t), t)
            g(" = \"mac#atspre_lnot\" ; ")
            g("overload ~ with lnot_%s\n", indexed(t))

            g("fun div_%s {a, b: %s | b <> 0} ", suffix, sort(t));
            g("(a: %s a, b: %s b):<> [a/b >= 0 && a/b <= a] %s (a/b)", t, t, t)
            g(" = \"mac#atspre_div\" ; ")
            g("overload / with div_%s\n", suffix)

            g("fun mod_%s {a, b: %s | b <> 0} ", suffix, sort(t));
            g("(a: %s a, b: %s b):<> [r: %s | r < b] %s r",
              t, t, sort(t), t)
            g(" = \"mac#atspre_mod\" ; ")
            g("overload mod with mod_%s\n", suffix)

            g("fun udiv2_%s {a, b: %s | b <> 0} ", suffix, sort(t));
            g("(a: %s a, b: %s b):<> (DIV (a, b, a/b) | %s (a/b))", t, t, t)
            g(" = \"mac#atspre_div\" ; ")
            g("overload udiv2 with udiv2_%s\n", suffix)

            g("fun umod2_%s {a, b: %s | b <> 0} ", suffix, sort(t));
            g("(a: %s a, b: %s b):<> [r: %s | r < b] (DIVMOD (a, b, a/b, r) | %s r)", t, t, sort(t), t)
            g(" = \"mac#atspre_mod\" ; ")
            g("overload umod2 with umod2_%s\n", suffix)

            g("fun ushl_%s {x: %s; n: nat; y: %s} ", suffix, sort(t), sort(t));
            g("(pf: SHL (x, n, y) | x: %s x, n: int n):<> %s y", t, t)
            g(" = \"mac#atspre_shl\" ; ")
            g("overload ushl with ushl_%s\n", suffix)

            g("fun ushr_%s {x: %s; n: nat} ", suffix, sort(t));
            g("(x: %s x, n: int n):<> [y: %s] (SHR (x, n, y) | %s y)", t, sort(t), t)
            g(" = \"mac#atspre_shr\" ; ")
            g("overload ushr with ushr_%s\n", suffix)

            g("fun shr_%s {x: %s; n: nat} ", suffix, sort(t));
            g("(x: %s x, n: int n):<> [y: %s] %s y", t, sort(t), t)
            g(" = \"mac#atspre_shr\" ; ")
            g("overload >> with shr_%s\n", suffix)

          end
        end
        if t1 == t2 and unsigned(t1) and not i1 and not i2 then
          t = t1
          suffix = indexed(t) .. "_" .. indexed(t)

          g("fun land_%s ", suffix);
          g("(a: %s, b: %s):<> %s", t, t, t)
          g(" = \"mac#atspre_land\" ; ")
          g("overload land with land_%s\n", suffix)

          g("fun lor_%s  ", suffix);
          g("(a: %s, b: %s):<> %s", t, t, t)
          g(" = \"mac#atspre_lor\" ; ")
          g("overload lor with lor_%s\n", suffix)

          g("fun lnot_%s  ", t);
          g("(a: %s):<> %s", t, t)
          g(" = \"mac#atspre_lnot\" ; ")
          g("overload ~ with lnot_%s\n", t)
        end
      end
    end
  end
end
    

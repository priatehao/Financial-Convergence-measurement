import excel "financial convergence measure.xlsx", sheet("Sheet1") firstrow  clear

egen id=group(省份)
xtset id 时间
generate lndkye=ln(贷款占GDP的比重)
pfilter lndkye, method(hp) trend(lndkye2) smooth(400)
logtreg lndkye2, kq(0.3)

///规模——贷款余额占GDP之比全国收敛
///综合指数收敛
center var1 var2 ... , prefix(z_) standardize
///标准化
egen id=group(省份)
xtset id 时间
generate lnzhzs=ln(综合指数)
pfilter lnzhzs, method(hp) trend(lnzhzs2) smooth(400)
logtreg lnzhzs2, kq(0.3)
psecta lnzhzs2, name(省份) kq(0.333) gen(club) noprt
matrix b=e(bm)
. matrix t=e(tm)
. matrix result1=(b \ t)
. matlist result1, border(rows) rowtitle("log(t)") format(%9.3f) left(4)
///俱乐部识别
 scheckmerge lnzhzs2, kq(0.333) club(club) mdiv
  matrix b=e(bm)
. matrix t=e(tm)
. matrix result2=(b \ t)
. matlist result2, border(rows) rowtitle("log(t)") format(%9.3f) left(4)

imergeclub lnzhzs2, name(省份) kq(0.333) club(club) gen(finalclub) noprt
 matrix b=e(bm)
. matrix t=e(tm)
. matrix result3=(b \ t)
. matlist result3, border(rows) rowtitle("log(t)") format(%9.3f) left(4)
///俱乐部合并







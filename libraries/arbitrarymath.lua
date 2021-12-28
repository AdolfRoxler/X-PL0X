meth = {}
function meth:round(X,decimallimit)
if decimallimit then else decimallimit = 0 end
decimalpointer = 10^decimallimit
return math.round(X*(decimalpointer))/decimalpointer
end
return meth
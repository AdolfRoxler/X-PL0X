meth = {}
function meth.round(X,decimallimit)
if decimallimit then else decimallimit = 0 end ---found doing this for every time I wanted to round exhausting so here's this piece of shit
decimalpointer = 10^math.abs(decimallimit)
return math.round(X*(decimalpointer))/decimalpointer
end
return meth
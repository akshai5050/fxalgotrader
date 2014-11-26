/ generate data for rdb demo

\l /Users/shaha1/db
i:0

ndat:{[]
        if[i<count trade;i+::1; :feed[.Q.ind[trade; enlist i-1]]]};

feed:{h("updat";x)}

h:hopen `::5011

while[not i=count trade; feed[.Q.ind[trade; enlist i]]; i+::1];

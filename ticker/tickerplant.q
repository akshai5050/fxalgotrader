/tickerplant code run on port 5011
/Dictionary to hold the subscriber's connections
Sub:(enlist `fx)!()

sub:{Sub[x],:.z.w}

updat:{t::x;if[(t[`date] < 2012.03.01)[0];pub each Sub `fx]}

pub:{[h] h("upd";`fx;t)}

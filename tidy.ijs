spread=: 1 : 0
'index';'key';'value'
index=. 0{::y
key=. 1{::y
value=. 2{::y
uk=. ({~/:) ~. key
ui=. ({~/:) ~. index
iind=. (({~/:) ~. index) i. index
kind=. (({~/:) ~. key) i. key
groups=. kind + (iind * (#uk))
groupnames=. ~. i.(# ui)*(# uk) NB. All possible group names.
NB. groupsselected =. ((value)&(#~))&.> (<"1 (groupnames =/ groups)) NB. this equality is way too inefficient
NB. summary =. ; u&.>groupsselected
si=. groups e.~ groupnames NB. Summary index by groupname. Unneccesary but nice to see. Note only use of groupnamaes.
NB. Alternative to using groupnames. si =. ((# ui)*(# uk)) # fill [ fill =. 0
summarygroups=. , groups u/. value NB. Oblique NB. ;u&.> groups </. value NB. Oblique
summary=. summarygroups (<"0 ~. groups) } si NB. Note that summarygroups is sorted by ~. groups.
NB. perm =. ((#uk)#ui ); (((#uk)*(#ui))$uk)
respivot=. (((#ui),(#uk))$i.((#ui)*(#uk))){summary
NB. res =. perm,<,.summary NB. This is the full summmary of unpivoted values.
ui;uk;respivot NB. This is index;key;pivoted values
)

gather=: 3 : 0
'index';'key';'value'
index=. 0{::y
key=. 1{::y
value=. 2{::y
rows=. (#key) # i.(#index)
cols=. ((#key)*(#index))$ i.(#key)
(rows { index);(cols { key); < ,.((rows,. cols) {::"1 _ value) NB. This is index;key;unpivoted values
)

reindex=: 4 : 0
fillvalue=. 0
io=. 0{::y
keys=. 1{::y
values=. 2{::y
reindexvalues=. io i.~ x
blank=. ((#x), (#keys)) $ fillvalue
rr=. reindexvalues
rc=. i.{:$ values
rir=. (#rc) # rr
ric=. ((#rc)*(#rr)) $ rc
rv=. (,values) (<"1 rir ,. ric) } blank
x ; keys; rv
)

rekey=: 4 : 0
fillvalue=. 0
ko=. 1{::y
indices=. 0{::y
values=. 2{::y
rekeyvalues=. ko i.~ x
blank=. ((#indices), (#x)) $ fillvalue
rr=. i.{.$ values
rc=. rekeyvalues
rir=. (#rc) # rr
ric=. ((#rc)*(#rr)) $ rc
rv=. (,values) (<"1 rir ,. ric) } blank
indices;x;rv
)

0 : 0
Examples:
'index';'key';'value'
c =. ,(7 10 $ '2000-01-032000-03-062000-03-082000-03-092000-03-062000-03-06');(,. 1813 2543 2543 2544 2546 2543 2548);(,. 0 1 _2 3 _4 5 _6 )
+/ spread c
gather +/ spread c
)

0 : 0

exampledata =. ,(,. 1813 2543 2543 2544 2546 2543 2548); (7 10 $ '2000-01-032000-03-062000-03-082000-03-092000-03-062000-03-06');(,. 0 1 _2 3 _4 5 _6 )
exampledata

key =. 0{:: exmapledata
index =. 1{:: exmapledata
value =. 2{:: exmapledata

uk =. ~. key
ui =. ~. index
iind =. (~. index) i. index
kind =. (~. key) i. key
NB. box for each key,index:
NB. calc on results:
groups =. kind + (iind * (#uk)) NB. group = multiply by index, add key
NB. groupnames =. ~. groups NB. This is wrong because it doesn't account for all permutations.
NB. This is the full expansion of the groupnames, rather than the shortcut.
NB. groupnames =.  , (i. # uk) +"1 ((#ui),(#uk) )$ (# ~.kind) # ((~. iind) * (#uk))
NB. This is the shortcut to all groupnames.
groupnames =. i.(# ui)*(# uk)
groupsselected =. ((value)&(#~))&.> (<"1 (groupnames =/ groups)) NB. Subset data into boxes by group.
perm =.(((#uk)*(#ui))$uk);(#uk)#ui NB. key,index

f =. +/   NB. Result of this executed on empty boxes will be the default value.
summary =. ; f&.>groupsselected
NB. These represent full permutations and summaries.
res =. perm,<,.summary
respivot =. (((#ui),(#uk))$i.((#ui)*(#uk))){summary

res NB. These are unpivoted values for each permutation.
uk NB. These are keys (to be pivoted for column names).
ui NB. These are indices (for row names).
respivot NB. These are summary values.
uk;uk;respivot


y =. blotter
10 head  blotterheader ,: blotter
head (<'SEC_ID = 7599') filter blotterheader ,: blotter
(<'SEC_ID = 7599') filter blotterheader ,: blotter
pivotqty =. +/ spread blotter NB. Net trades on same asset, same day (with +/ function)
head positionstojd pivotqty
head ('ENDDATE';'7599') select positionstojd pivotqty
head (<'SEC_ID = 7599') filter blotterheader ,: res

)


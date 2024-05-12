--find columns in tablesfor a schema
select
	`table`,
	name,
	`type`,
	`position`,
		`database`
from
	system.columns
where
	`database` = '${schema}'
order by
	table,
	position;

--all columns
SELECT 	position, name, type, default_kind
FROM system.columns 
WHERE database = '${schema}' and table = '${table}' 
ORDER BY position;

--remind final: engine type 
select engine, database, name
from 	system.tables 
WHERE database = '${schema}' and name = '${table}'; 

-- overview
select *,count() ct from ${schema}.${table} group by all
--order by ct desc; --(doublets)

select ${id_col},count() ct from ${schema}.${table} --final
group by ${id_col}
order by ct desc, ${id_col}; --(doublets light versin)


--overview plain
select * from ${schema}.${table};

--ct all
select count(*) from ${schema}.${table};

--ct distinct col
select count(distinct ${ct_distinct_col}) from ${schema}.${table};

-- pivot
with t as (
Select
	grouping(${col1_to_grp}, ${col2_to_grp}) result_rows,
	multiIf(result_rows > 0 and result_rows < pow(2,2)-1, 
					concat('Subtotal',toString(log2(result_rows+1))), 
					result_rows = pow(2,2)-1, 'Total', '    ') pivot,
	${col1_to_grp}, ${col2_to_grp}
	,
	count() ct
from
	${schema}.${table} --final
	--where ${col1_to_grp} = '${grp_to_filter1_val}'
	--where ${col2_to_grp} = '${grp_to_filter2_val}'
	--and ${col_to_filter3} = '${col_to_filter3_val}'
	--and ${col_to_filter4} = '${col_to_filter4_val}'
	--and ${col_to_filter5} = '${col_to_filter5_val}'
	--and ${col_to_filter6} = '${col_to_filter6_val}'
	--and ${col_to_filter7} = '${col_to_filter7_val}'
	--and ${col_to_filter8} = '${col_to_filter8_val}'
	--and ${col_to_filter9} = '${col_to_filter9_val}'
	--and ${col_to_filter10} = '${col_to_filter10_val}'
		--where ${col1_to_grp} in (${grp_to_filter1_val})
	--and ${col2_to_grp} in (${grp_to_filter2_val})
	--and ${col_to_filter3} in (${col_to_filter3_val})
	--and ${col_to_filter4} in (${col_to_filter4_val})
	--and ${col_to_filter5} in (${col_to_filter5_val})
	--and ${col_to_filter6} in (${col_to_filter6_val})
	--and ${col_to_filter7} in (${col_to_filter7_val})
	--and ${col_to_filter8} in (${col_to_filter8_val})
	--and ${col_to_filter9} in (${col_to_filter9_val})
	--and ${col_to_filter10} in (${col_to_filter10_val})
--		where ${col_to_filter1} in (${col_to_filter1_val})
	--and ${col_to_filter2} in (${col_to_filter2_val})
	--and ${col_to_filter3} in (${col_to_filter3_val})
	--and ${col_to_filter4} in (${col_to_filter4_val})
	--and ${col_to_filter5} in (${col_to_filter5_val})
	--and ${col_to_filter6} in (${col_to_filter6_val})
	--and ${col_to_filter7} in (${col_to_filter7_val})
	--and ${col_to_filter8} in (${col_to_filter8_val})
	--and ${col_to_filter9} in (${col_to_filter9_val})
	--and ${col_to_filter10} in (${col_to_filter10_val})
	--where ${col_to_filter1} ${col_to_filter1_condition}
	--where ${col_to_filter2} ${col_to_filter2_condition}
	--and ${col_to_filter3} ${col_to_filter3_condition}
	--and ${col_to_filter4} ${col_to_filter4_condition}
	--and ${col_to_filter5} ${col_to_filter5_condition}
	--and ${col_to_filter6} ${col_to_filter6_condition}
	--and ${col_to_filter7} ${col_to_filter7_condition}
	--and ${col_to_filter8} ${col_to_filter8_condition}
	--and ${col_to_filter9} ${col_to_filter9_condition}
	--and ${col_to_filter10} ${col_to_filter10_condition}
group by
	${col1_to_grp}, 
	${col2_to_grp}	
	with rollup
--SWITCH-OFF/ON the Subtotals
having pivot in ('    ', 'Total')
--having pivot in ('    ', 'Total', 'Subtotal4')
order by
	result_rows desc,
	--ct desc,
	${col1_to_grp} desc
	, 
	${col2_to_grp} --desc
	${frontend_bound}
	),
t1 as(
select
	*,
	row_number() over (partition by (pivot,	${col1_to_grp} ) order by ${col2_to_grp}) as grpno_1_type
from
	t
)
select
	pivot,
	if(grpno_1_type = 1, toString(${col1_to_grp}),	'') ${col1_to_grp}_,
	${col2_to_grp},
	ct
from
	t1
	-->where: <NO filters here!!>
order by
	result_rows desc,
	${col1_to_grp} desc
	,
	${col2_to_grp} --desc
;


--full drill down
select * from(
select *
--,count() 
from ${schema}.${table} 
	where ${col1_to_grp} = '${grp_to_filter1_val}'
	--and ${col2_to_grp} = '${grp_to_filter2_val}'
	--and ${col_to_filter3} = '${col_to_filter3_val}'
	--and ${col_to_filter4} = '${col_to_filter4_val}'
	--and ${col_to_filter5} = '${col_to_filter5_val}'
	--and ${col_to_filter6} = '${col_to_filter6_val}'
	--and ${col_to_filter7} = '${col_to_filter7_val}'
	--and ${col_to_filter8} = '${col_to_filter8_val}'
	--and ${col_to_filter9} = '${col_to_filter9_val}'
	--and ${col_to_filter10} = '${col_to_filter10_val}'
		--where ${col1_to_grp} in (${grp_to_filter1_val})
	--and ${col2_to_grp} in (${grp_to_filter2_val})
	--and ${col_to_filter3} in (${col_to_filter3_val})
	--and ${col_to_filter4} in (${col_to_filter4_val})
	--and ${col_to_filter5} in (${col_to_filter5_val})
	--and ${col_to_filter6} in (${col_to_filter6_val})
	--and ${col_to_filter7} in (${col_to_filter7_val})
	--and ${col_to_filter8} in (${col_to_filter8_val})
	--and ${col_to_filter9} in (${col_to_filter9_val})
	--and ${col_to_filter10} in (${col_to_filter10_val})
	--	where ${col_to_filter1} in (${col_to_filter1_val})
	--and ${col_to_filter1} in (${col_to_filter1_val})
	--and ${col_to_filter2} in (${col_to_filter2_val})
	--and ${col_to_filter3} in (${col_to_filter3_val})
	--and ${col_to_filter4} in (${col_to_filter4_val})
	--and ${col_to_filter5} in (${col_to_filter5_val})
	--and ${col_to_filter6} in (${col_to_filter6_val})
	--and ${col_to_filter7} in (${col_to_filter7_val})
	--and ${col_to_filter8} in (${col_to_filter8_val})
	--and ${col_to_filter9} in (${col_to_filter9_val})
	--and ${col_to_filter10} in (${col_to_filter10_val})
		--where ${col_to_filter1} ${col_to_filter1_condition}
	--and ${col_to_filter2} ${col_to_filter2_condition}
	--and ${col_to_filter3} ${col_to_filter3_condition}
	--and ${col_to_filter4} ${col_to_filter4_condition}
	--and ${col_to_filter5} ${col_to_filter5_condition}
	--and ${col_to_filter6} ${col_to_filter6_condition}
	--and ${col_to_filter7} ${col_to_filter7_condition}
	--and ${col_to_filter8} ${col_to_filter8_condition}
	--and ${col_to_filter9} ${col_to_filter9_condition}
	--and ${col_to_filter10} ${col_to_filter10_condition}
--group by all 
order by ide) settings final = 1
;	


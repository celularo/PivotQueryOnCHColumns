# PivotStretches
Some generic stretches to show pivot tables of columns for a db in dbeaver. Here in a ClickHouse syntax.

## Supported functionalities

### Placing column objects as Pivot-column headers
Not supported.

### Placing key-figures as Pivot-columns headers
Supported in the Advanced Type.


### Placing column objects as Pivot-row headers
Supported up to 11 Column objects. In principle possible for n up to hardware.

### Totals and Subtotals
Supported as block on top of the pivot table. Possibility to swich-on/off each group of subtotals seperately.

### Group headers
Supported at the beginning of each goup. (similar to a version of the SQL-Plus functionality `BREAK on`)

### Complete drill-down to details
Supported at the end of each sql-snippet. cf. comment.

### Filters
Supported in 3 different kinds: `=`, `in` and completely arbitrary conditions.

### Save Constellations
Supported via the scripts StndSettingDril#.sql, where  `@set` commends for all variables can be found.
The `@unset` Command has no representative in templates, since it can be performed using the dbeaver variable panel.

### Frontend bound
A variable for the `LIMIT` clause lives at the end of the first `ORDER BY` clause in each query. Recommended is a value
below the dbeaver frontend bound for the page size of the hitlist.

### Drill deep columns: Arrays
clickhouse's / generic query's array behaviour depends on the position in the list of columns you want to drill:
+ drill in final position: totally array-ready
+ drill in any other position: array_readable, means string concat version of the full array

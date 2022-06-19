## Select all records
```
select * from users;
```

## Count records
```
select count(*) from users;
```

## Where clause
```
select * from users
where first_name='Rakesh';
```

## Where with and
```
select * from users
where first_name='Rakesh'
and last_name='Raut';
```

## Where with or
```
select * from users
where first_name='Rakesh'
or first_name='Tom';
```

## Group records by column and print count
```
select count(*), role from users
group  by  role;
```

## Group by with having
```
select count(*), role from users
group  by  role
having  role='admin';
```

##  Inner Join two tables
```
select u.first_name, j.title
from users u
inner  join jobs j
on u.id = j.user_id;
```
or

```
select u.first_name, j.title
from users as u
inner  join jobs as j
on u.id = j.user_id;
```

## Get unique records
```
select  distinct category
from jobs;
```

## Count distinct records
```
select count(distinct category)
from jobs;
```

## Order by ascending
```
select * from users
order by first_name;
```

## Order by descending
```
select * from users
order by first_name desc;
```

## Find by null column
```
select * from users
where company_id is null;
```

## Find where column is not null
```
select * from users
where company_id is not null;

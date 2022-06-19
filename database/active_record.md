## Select all records
```
User.all
```

## Count records
```
User.count
```

## Where clause
```
User.where(first_name: 'Rakesh')
```

## Where with and
```
User.where(first_name: 'Rakesh', last_name: 'Raut')
```

## Where with or
```
User.where(first_name: 'Rakesh').or(User.where(first_name: 'Tom'))
```

## Group records by column and print count
```
User.group(:role).count
```

## Group by with having
```
User.group(:role).where(role: 'admin').count
```

##  Inner Join two tables
```
User.joins(:jobs)
```

```
User.joins(:jobs).where(users: { role: 'admin' })
```

```
users = User.joins(:jobs).select('user.id, users.first_name, jobs.title') # this won't show title
users.first.title # to get the title of job
```

## Get unique records
```
Job.distinct.pluck(:category)
```

## Count distinct records
```
Job.distinct.pluck(:category).count
```

## Order by ascending
```
User.order(:first_name)
```

## Order by descending
```
 User.order(first_name: :desc)
```

## Find by null column
```
User.where(company_id: nil)
```

## Find where column is not null
```
User.where.not(company_id: nil)
```
## Find Missing association (Rails 6.1+)
```
User.where.missing(:company)
```

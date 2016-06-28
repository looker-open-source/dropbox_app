- view: files
  sql_table_name: public.files
  fields:

  - dimension: extension
    type: string
    sql: ${TABLE}.extension

  - dimension_group: modified
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.modified

  - dimension: path
    type: string
    sql: ${TABLE}.path

  - dimension: shared
    type: yesno
    sql: ${TABLE}.shared

  - dimension: size_bytes
    type: number
    sql: ${TABLE}.size_bytes

#   - dimension: size_formatted
#     type: string
#     sql: ${TABLE}.size_formatted

  - dimension: user_email
    type: string
    sql: ${TABLE}.user_email

  - measure: count
    type: count
    drill_fields: []


- view: groups
  sql_table_name: public.groups
  fields:

  - dimension: access_type
    type: string
    sql: ${TABLE}.access_type

  - dimension: display_name
    type: string
    sql: ${TABLE}.display_name

  - dimension: email
    type: string
    sql: ${TABLE}.email

  - dimension: group_name
    type: string
    sql: coalesce(${TABLE}.group_name,'No Group')

  - dimension: member_count
    type: number
    sql: ${TABLE}.member_count

  - dimension: membership_type
    type: string
    sql: ${TABLE}.membership_type

  - measure: count
    type: count
    drill_fields: [group_name, display_name]


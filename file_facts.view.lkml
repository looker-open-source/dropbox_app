view: file_facts {
  derived_table: {
    ## Persistent Derived Table SQL avoids window functions to cover larger range of SQL dialects
    sortkeys: ["file_created_date"]
    distribution: "path"
    sql_trigger_value: SELECT CURRENT_DATE ;;
    sql: SELECT  file_facts.path
        , file_facts.latest_modified_date
        , file_facts.file_created_date
        , file_facts.file_edits
        , file_create_facts.user_email as file_created_user
        , file_create_facts.size_bytes as file_created_bytes
        , file_latest_facts.user_email as file_latest_modified_user
        , file_latest_facts.size_bytes as file_latest_modified__bytes
FROM
  (SELECT
  path,
  max(modified) as latest_modified_date,
  min(modified) as file_created_date,
  count(*) as file_edits
  FROM public.files AS files
  group by 1
  ) as file_facts
INNER JOIN public.files as file_create_facts
  ON file_facts.path = file_create_facts.path AND file_facts.file_created_date = file_create_facts.modified
INNER JOIN public.files as file_latest_facts
  ON file_facts.path = file_latest_facts.path AND file_facts.latest_modified_date = file_latest_facts.modified
 ;;
  }

  dimension: path {
    primary_key: yes
    hidden: yes
    type: string
    sql: ${TABLE}.path ;;
  }

  dimension_group: latest_modified {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      year
    ]
    sql: ${TABLE}.latest_modified_date ;;
  }

  dimension_group: file_created {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      year
    ]
    sql: ${TABLE}.file_created_date ;;
  }

  dimension: file_edits {
    type: number
    sql: ${TABLE}.file_edits ;;
  }

  dimension: file_created_user {
    type: string
    sql: ${TABLE}.file_created_user ;;
  }

  dimension: file_created_bytes {
    type: number
    sql: ${TABLE}.file_created_bytes ;;
  }

  dimension: file_latest_modified_user {
    type: string
    sql: ${TABLE}.file_latest_modified_user ;;
  }

  dimension: file_latest_modified__bytes {
    type: number
    sql: ${TABLE}.file_latest_modified__bytes ;;
  }

  set: detail {
    fields: [
      path,
      file_edits,
      file_created_user,
      file_created_bytes,
      file_latest_modified_user,
      file_latest_modified__bytes
    ]
  }
}

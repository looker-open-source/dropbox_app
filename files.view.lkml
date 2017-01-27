view: files {
  sql_table_name: public.files ;;

  dimension: extension {
    type: string
    sql: ${TABLE}.extension ;;
  }

  dimension_group: modified {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      year
    ]
    sql: ${TABLE}.modified ;;
  }

  dimension: path {
    type: string
    sql: ${TABLE}.path ;;
  }

  dimension: shared {
    type: yesno
    sql: ${TABLE}.shared ;;
  }

  dimension: size_bytes {
    type: number
    sql: ${TABLE}.size_bytes ;;
  }

  dimension: size_formatted {
    type: string
    sql: ${TABLE}.size_formatted ;;
  }

  dimension: user_email {
    type: string
    sql: ${TABLE}.user_email ;;
  }

  measure: count_edits {
    #     description: "Includes File Adds"
    type: count
    drill_fields: []
  }

  measure: count_files {
    type: count_distinct
    sql: ${path} ;;
  }

  measure: max_file_size_bytes {
    type: max
    sql: ${size_bytes} ;;
  }

  measure: min_file_size_bytes {
    type: min
    sql: ${size_bytes} ;;
  }
}

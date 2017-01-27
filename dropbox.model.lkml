connection: "dropbox_looker"

# include all the views
include: "*.view"

# include all the dashboards
include: "*.dashboard"

explore: files {
  join: groups {
    sql_on: ${files.user_email} = ${groups.email} ;;
    relationship: many_to_one
  }

  join: file_facts {
    sql_on: ${files.path} = ${file_facts.path} ;;
    relationship: many_to_one
    view_label: "Files"
  }
}

explore: events {
  join: groups {
    sql_on: ${events.email} = ${groups.email} ;;
    relationship: many_to_one
  }

  join: file_facts {
    sql_on: ${events.info_path} = ${file_facts.path} ;;
    relationship: many_to_one
  }

  join: groups_target {
    from: groups
    sql_on: ${events.info_email_simplified} = ${groups.email} ;;
    relationship: many_to_one
  }
}

explore: groups {}

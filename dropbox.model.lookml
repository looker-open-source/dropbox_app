- connection: dropbox_looker

- include: "*.view.lookml"       # include all the views
- include: "*.dashboard.lookml"  # include all the dashboards

- explore: files
  joins: 
  - join: groups
    sql_on: ${files.user_email} = ${groups.email}
    relationship: many_to_one
  
  - join: file_facts
    sql_on: ${files.path} = ${file_facts.path}
    relationship: many_to_one
    view_label: "Files"

- explore: events
  joins: 
  - join: groups
    sql_on: ${events.email} = ${groups.email}
    relationship: many_to_one
  
  - join: file_facts
    sql_on: ${events.info_path} = ${file_facts.path}
    relationship: many_to_one
  
  - join: groups_target
    from: groups
    sql_on: ${events.info_email_simplified} = ${groups.email}
    relationship: many_to_one
    
- explore: groups
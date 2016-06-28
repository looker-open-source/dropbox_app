- view: events
  sql_table_name: public.sanitized_events
  fields:

  - dimension: country
    type: string
    sql: ${TABLE}.country

  - dimension: email
    type: string
    sql: ${TABLE}.email

  - dimension: event_category
    type: string
    sql: ${TABLE}.event_category

  - dimension: event_type
    type: string
    sql: ${TABLE}.event_type
  
  - dimension: event_name
    sql_case:
      Authorized an Application: ${event_type} = 'app_allow'
      Removed an Application: ${event_type} = 'app_remove'
      Linked a Device:  ${event_type} = 'device_link'
      Removed a Device: ${event_type} = 'device_unlink'
      Invited Non-Team Member(s) to a Shared Folder: ${event_type} = 'sf_nonteam_invite'
      Joined a shared folder (non-team member): ${event_type} = 'sf_nonteam_join' 
      Invited team member(s) to a shared folder: ${event_type} = 'sf_team_invite'
      Joined a shared folder (team member): ${event_type} = 'sf_team_join'
      Downloaded the contents of a link (non-team member): ${event_type} = 'shmodel_nonteam_download'
      Opened a link (non-team member): ${event_type} = 'shmodel_nonteam_view'
      Downloaded the contents of a link (team member): ${event_type} = 'shmodel_team_download'
      Opened a link (team member): ${event_type} = 'shmodel_team_view'


  - dimension: info_app_id
    type: number
    sql: ${TABLE}.info_app_id

  - dimension: info_base_name
    type: string
    sql: ${TABLE}.info_base_name

  - dimension: info_display_name
    type: string
    sql: ${TABLE}.info_display_name

  - dimension: info_email
    type: string
    sql: ${TABLE}.info_email

  - dimension: info_link_owner_email
    type: string
    sql: ${TABLE}.info_link_owner_email

  - dimension: info_link_owner_name
    type: string
    sql: ${TABLE}.info_link_owner_name

  - dimension: info_name
    type: string
    sql: ${TABLE}.info_name

  - dimension: info_orig_folder_name
    type: string
    sql: ${TABLE}.info_orig_folder_name

  - dimension: info_path
    type: string
    sql: ${TABLE}.info_path

  - dimension: info_platform
    type: string
    sql: ${TABLE}.info_platform

  - dimension: info_shared_folder_id
    type: number
    sql: ${TABLE}.info_shared_folder_id

  - dimension: info_target_user_email
    type: string
    sql: ${TABLE}.info_target_user_email

  - dimension: info_target_user_name
    type: string
    sql: ${TABLE}.info_target_user_name

  - dimension: ip_address
    type: string
    sql: ${TABLE}.ip_address

  - dimension: name
    type: string
    sql: ${TABLE}.name

  - dimension_group: event
    type: time
    timeframes: [time, date, week, month]
    convert_tz: false
    sql: ${TABLE}.time

  - measure: count
    type: count
    drill_fields: detail*


  # ----- Sets of fields for drilling ------
  sets:
    detail:
    - name
    - info_orig_folder_name
    - info_base_name
    - info_link_owner_name
    - info_target_user_name
    - info_name
    - info_display_name


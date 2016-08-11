- view: events
  sql_table_name: public.sanitized_events
  fields:

  - dimension: country
    map_layer: countries
    sql: ${TABLE}.country

  - dimension: email
    type: string
    sql: ${TABLE}.email
  
  - dimension: email_domain
    type: string
    sql: split_part(${email},'@',2)

  - dimension: is_internal
    type: yesno
    sql: ${email_domain} = 'hanfordinc.com' ##change for relevant internal email domain
    
  - dimension: event_category
    type: string
    sql: ${TABLE}.event_category

  - dimension: event_type
    type: string
    hidden: true
    sql: ${TABLE}.event_type
  
  - dimension: event_name
    group_label: "Event Type"
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
  
  - dimension: is_folder_share_event
    type: yesno
    group_label: "Event Type"
    sql: ${event_type} in ('sf_nonteam_invite', 'sf_team_invite')
  
  - dimension: is_folder_join_event
    type: yesno
    group_label: "Event Type"
    sql: ${event_type} in ('sf_nonteam_join', 'sf_team_join')
  
  - dimension: is_folder_event
    type: yesno
    group_label: "Event Type"
    sql: ${event_type} in ('sf_nonteam_invite', 'sf_team_invite', 'sf_nonteam_join', 'sf_team_join')

  - dimension: is_link_open_event
    type: yesno
    group_label: "Event Type"
    sql: ${event_type} in ('shmodel_nonteam_view','shmodel_team_view')
    
  - dimension: is_link_download_event
    type: yesno
    group_label: "Event Type"
    sql:  ${event_type} in ('shmodel_team_download','shmodel_nonteam_download')
  
  - dimension: is_link_event
    type: yesno
    group_label: "Event Type"
    sql: ${event_type} in ('shmodel_nonteam_view','shmodel_team_view', 'shmodel_team_download','shmodel_nonteam_download')
    
  - dimension: info_email_simplified
    type: string 
    sql: coalesce(${info_email},${info_link_owner_email},${info_target_user_email})
 
  - dimension: is_info_email_internal
    type: yesno
    sql: ${info_email_simplified} = 'dropbox.com' ##change for relevant internal email domain
  
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

  - dimension: folder_name
    type: string
    sql: ${TABLE}.info_orig_folder_name

  - dimension: info_path
    type: string
    sql: ${TABLE}.info_path

  - dimension: info_platform
    type: string
    sql: ${TABLE}.info_platform

  - dimension: folder_id
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
  
  - measure: count_folder_shares
    type: count
    filter: 
      is_folder_share_event: yes
  
  - measure: count_folder_joins
    type: count
    filter: 
      is_folder_join_event: yes
  
  - measure: count_link_opens
    type: count
    filter: 
      is_link_open_event: yes
  
  - measure: count_link_downloads
    type: count
    filter: 
      is_link_download_event: yes


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


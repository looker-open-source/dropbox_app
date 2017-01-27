view: events {
  sql_table_name: public.sanitized_events ;;

  dimension: country {
    map_layer_name: countries
    sql: ${TABLE}.country ;;
  }

  dimension: email {
    type: string
    sql: ${TABLE}.email ;;
  }

  dimension: email_domain {
    type: string
    sql: split_part(${email},'@',2) ;;
  }

  dimension: is_internal {
    type: yesno
    ##change for relevant internal email domain
    sql: ${email_domain} = 'hanfordinc.com' ;;
  }

  dimension: event_category {
    type: string
    sql: ${TABLE}.event_category ;;
  }

  dimension: event_type {
    type: string
    hidden: yes
    sql: ${TABLE}.event_type ;;
  }

  dimension: event_name {
    group_label: "Event Type"

    case: {
      when: {
        sql: ${event_type} = 'app_allow' ;;
        label: "Authorized an Application"
      }

      when: {
        sql: ${event_type} = 'app_remove' ;;
        label: "Removed an Application"
      }

      when: {
        sql: ${event_type} = 'device_link' ;;
        label: "Linked a Device"
      }

      when: {
        sql: ${event_type} = 'device_unlink' ;;
        label: "Removed a Device"
      }

      when: {
        sql: ${event_type} = 'sf_nonteam_invite' ;;
        label: "Invited Non-Team Member(s) to a Shared Folder"
      }

      when: {
        sql: ${event_type} = 'sf_nonteam_join' ;;
        label: "Joined a shared folder (non-team member)"
      }

      when: {
        sql: ${event_type} = 'sf_team_invite' ;;
        label: "Invited team member(s) to a shared folder"
      }

      when: {
        sql: ${event_type} = 'sf_team_join' ;;
        label: "Joined a shared folder (team member)"
      }

      when: {
        sql: ${event_type} = 'shmodel_nonteam_download' ;;
        label: "Downloaded the contents of a link (non-team member)"
      }

      when: {
        sql: ${event_type} = 'shmodel_nonteam_view' ;;
        label: "Opened a link (non-team member)"
      }

      when: {
        sql: ${event_type} = 'shmodel_team_download' ;;
        label: "Downloaded the contents of a link (team member)"
      }

      when: {
        sql: ${event_type} = 'shmodel_team_view' ;;
        label: "Opened a link (team member)"
      }
    }
  }

  dimension: is_folder_share_event {
    type: yesno
    group_label: "Event Type"
    sql: ${event_type} in ('sf_nonteam_invite', 'sf_team_invite') ;;
  }

  dimension: is_folder_join_event {
    type: yesno
    group_label: "Event Type"
    sql: ${event_type} in ('sf_nonteam_join', 'sf_team_join') ;;
  }

  dimension: is_folder_event {
    type: yesno
    group_label: "Event Type"
    sql: ${event_type} in ('sf_nonteam_invite', 'sf_team_invite', 'sf_nonteam_join', 'sf_team_join') ;;
  }

  dimension: is_link_open_event {
    type: yesno
    group_label: "Event Type"
    sql: ${event_type} in ('shmodel_nonteam_view','shmodel_team_view') ;;
  }

  dimension: is_link_download_event {
    type: yesno
    group_label: "Event Type"
    sql: ${event_type} in ('shmodel_team_download','shmodel_nonteam_download') ;;
  }

  dimension: is_link_event {
    type: yesno
    group_label: "Event Type"
    sql: ${event_type} in ('shmodel_nonteam_view','shmodel_team_view', 'shmodel_team_download','shmodel_nonteam_download') ;;
  }

  dimension: info_email_simplified {
    type: string
    sql: coalesce(${info_email},${info_link_owner_email},${info_target_user_email}) ;;
  }

  dimension: is_info_email_internal {
    type: yesno
    ##change for relevant internal email domain
    sql: ${info_email_simplified} = 'dropbox.com' ;;
  }

  dimension: info_email_simplified_domain {
    type: string
    sql: split_part(${info_email_simplified},'@',2) ;;
  }

  dimension: info_app_id {
    type: number
    sql: ${TABLE}.info_app_id ;;
  }

  dimension: info_base_name {
    type: string
    sql: ${TABLE}.info_base_name ;;
  }

  dimension: info_display_name {
    type: string
    sql: ${TABLE}.info_display_name ;;
  }

  dimension: info_email {
    type: string
    sql: ${TABLE}.info_email ;;
  }

  dimension: info_link_owner_email {
    type: string
    sql: ${TABLE}.info_link_owner_email ;;
  }

  dimension: info_link_owner_name {
    type: string
    sql: ${TABLE}.info_link_owner_name ;;
  }

  dimension: info_name {
    type: string
    sql: ${TABLE}.info_name ;;
  }

  dimension: folder_name {
    type: string
    sql: ${TABLE}.info_orig_folder_name ;;
  }

  dimension: info_path {
    type: string
    sql: ${TABLE}.info_path ;;
  }

  dimension: info_platform {
    type: string
    sql: ${TABLE}.info_platform ;;
  }

  dimension: folder_id {
    type: number
    sql: ${TABLE}.info_shared_folder_id ;;
  }

  dimension: info_target_user_email {
    type: string
    sql: ${TABLE}.info_target_user_email ;;
  }

  dimension: info_target_user_name {
    type: string
    sql: ${TABLE}.info_target_user_name ;;
  }

  dimension: ip_address {
    type: string
    sql: ${TABLE}.ip_address ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
  }

  dimension_group: event {
    type: time
    timeframes: [time, date, week, month]
    convert_tz: no
    sql: ${TABLE}.time ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  measure: count_folder_shares {
    type: count

    filters: {
      field: is_folder_share_event
      value: "yes"
    }
  }

  measure: count_folder_joins {
    type: count

    filters: {
      field: is_folder_join_event
      value: "yes"
    }
  }

  measure: count_link_opens {
    type: count

    filters: {
      field: is_link_open_event
      value: "yes"
    }
  }

  measure: count_link_downloads {
    type: count

    filters: {
      field: is_link_download_event
      value: "yes"
    }
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      name,
      info_base_name,
      info_link_owner_name,
      info_target_user_name,
      info_name,
      info_display_name
    ]
  }
}

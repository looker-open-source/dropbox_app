- dashboard: folder_overview
  title: Folder Overview
  layout: grid
  rows:
    - elements: [folder_joins, folder_shares]
      height: 220
    - elements: [top_15_user_folder_share, top_15_user_folder_share_table]
      height: 400
    - elements: [folder_joins_by_group_name, joined_folder]
      height: 400
    - elements: [group_to_group, folders_by_email_domain]
      height: 400

  filters:

  - name: date
    title: "Date"
    type: date_filter
#     default_value: Last 90 Days

  - name: folder_name
    type: field_filter
    explore: events
    field: events.folder_name
    default_value: Team1_shared

  elements:

  - name: folder_joins
    title: Folder Joins
    type: single_value
    model: dropbox
    explore: events
    measures: [events.count_folder_joins]
    listen:
      date: events.event_date
      folder_name: events.folder_name
    sorts: [events.count_folder_joins desc]
    limit: 500
    show_single_value_title: true
    show_comparison: false

  - name: folder_shares
    title: Folder Shares
    type: single_value
    model: dropbox
    explore: events
    measures: [events.count_folder_shares]
    listen:
      date: events.event_date
      folder_name: events.folder_name
    sorts: [events.count_folder_shares desc]
    limit: 500
    show_single_value_title: true
    show_comparison: false


  - name: top_15_user_folder_share
    title: Top 15 Users by Count Folder Shares
    type: looker_bar
    model: dropbox
    explore: events
    dimensions: [events.email]
    measures: [events.count_folder_shares]
    listen:
      date: events.event_date
      folder_name: events.folder_name
    filters:
      events.is_folder_share_event: 'Yes'
    hidden_fields: [total]
    sorts: [events.count_folder_shares desc]
    limit: 15
    column_limit: 50
    stacking: ''
    colors: ['#5245ed', '#ed6168', '#1ea8df', '#353b49', '#49cec1', '#b3a0dd', '#db7f2a',
      '#706080', '#a2dcf3', '#776fdf', '#e9b404', '#635189']
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    show_null_labels: false

  - name: top_15_user_folder_share_table
    title: Users by Folder Share (Broken down by Team and Non-Team)
    type: table
    model: dropbox
    explore: events
    dimensions: [events.event_name, events.email]
    pivots: [events.event_name]
    measures: [events.count_folder_shares]
    dynamic_fields:
    - table_calculation: total
      label: Total
      expression: coalesce(pivot_index(${events.count_folder_shares},1),0) + coalesce(pivot_index(${events.count_folder_shares},2),0)
    listen:
      date: events.event_date
      folder_name: events.folder_name
    filters:
      events.is_folder_share_event: 'Yes'
    sorts: [events.event_name, events.event_name__sort_, total desc]
    limit: 500
    column_limit: 50
    show_view_names: false
    show_row_numbers: true
    truncate_column_names: false
    table_theme: gray
    limit_displayed_rows: false

  - name: joined_folder
    title: Joined Folder
    type: table
    model: dropbox
    explore: events
    dimensions: [events.event_time, events.email]
    listen:
      date: events.event_date
      folder_name: events.folder_name
    filters:
      events.is_folder_join_event: 'Yes'
    sorts: [events.event_time]
    limit: 15
    column_limit: 50
    show_view_names: false
    show_row_numbers: true
    truncate_column_names: false
    table_theme: gray
    limit_displayed_rows: false

  - name: folders_by_email_domain
    title: Folder Metrics by Email Domain
    type: looker_column
    model: dropbox
    explore: events
    dimensions: [events.email_domain]
    measures: [events.count_folder_joins, events.count_folder_shares]
    listen:
      date: events.event_date
      folder_name: events.folder_name
    sorts: [events.count_folder_joins desc]
    limit: 15
    column_limit: 50
    stacking: ''
    colors: ['#5245ed', '#ed6168', '#1ea8df', '#353b49', '#49cec1', '#b3a0dd', '#db7f2a',
      '#706080', '#a2dcf3', '#776fdf', '#e9b404', '#635189']
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    show_null_labels: false

  - name: folder_joins_by_group_name
    title: Folder Joins and Shares By Group Name
    type: looker_bar
    model: dropbox
    explore: events
    dimensions: [groups.group_name]
    measures: [events.count_folder_joins, events.count_folder_shares]
    listen:
      date: events.event_date
      folder_name: events.folder_name
    sorts: [events.count_folder_joins desc]
    limit: 15
    column_limit: 50
    stacking: ''
    colors: ['#5245ed', '#ed6168', '#1ea8df', '#353b49', '#49cec1', '#b3a0dd', '#db7f2a',
      '#706080', '#a2dcf3', '#776fdf', '#e9b404', '#635189']
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    show_null_labels: false

  - name: group_to_group
    title: Top 15 Group to Group Sharing by Invite Count (including No Group specified)
    type: looker_bar
    model: dropbox
    explore: events
    dimensions: [groups.group_name, groups_target.group_name]
    measures: [events.count]
    listen:
      date: events.event_date
      folder_name: events.folder_name
    filters:
      events.event_name: Invited team member(s) to a shared folder
    sorts: [events.count desc]
    limit: 15
    stacking: ''
    colors: ['#5245ed', '#ed6168', '#1ea8df', '#353b49', '#49cec1', '#b3a0dd', '#db7f2a',
      '#706080', '#a2dcf3', '#776fdf', '#e9b404', '#635189']
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    show_null_labels: false








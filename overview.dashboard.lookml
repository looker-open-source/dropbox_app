- dashboard: overview
  title: Overview
  layout: grid
  rows:
    - elements: [cnt_folder_joins, cnt_folder_shares, cnt_link_opens, cnt_link_dwnlds]
      height: 220
    - elements: [top_15_folder_shares_by_folder, folder_metrics]
      height: 400
    - elements: [group_to_group_share_bar, group_to_group_folder_table]
      height: 400
    - elements: [top_15_links, links_by_downloads_and_opens]
      height: 400
  filters:

  - name: date
    title: "Date"
    type: date_filter
#     default_value: Last 90 Days

  elements:

  - name: cnt_folder_joins
    title: Count Folder Joins
    type: single_value
    model: dropbox
    explore: events
    measures: [events.count_folder_joins]
    listen: 
      date: events.event_date
    sorts: [events.count desc]
    limit: 500
    column_limit: 50
    show_single_value_title: true
    show_comparison: false
  
  - name: cnt_folder_shares
    title: Count Folder Shares
    type: single_value
    model: dropbox
    explore: events
    measures: [events.count_folder_shares]
    listen: 
      date: events.event_date
    sorts: [events.count desc]
    limit: 500
    column_limit: 50
    show_single_value_title: true
    show_comparison: false

  - name: cnt_link_opens
    title: Count Link Opens
    type: single_value
    model: dropbox
    explore: events
    measures: [events.count_link_opens]
    listen: 
      date: events.event_date
    limit: 500
    column_limit: 50
    show_single_value_title: true
    show_comparison: false
  
  - name: cnt_link_dwnlds
    title: Count Link Downloads
    type: single_value
    model: dropbox
    explore: events
    measures: [events.count_folder_shares]
    listen: 
      date: events.event_date
    limit: 500
    column_limit: 50
    show_single_value_title: true
    show_comparison: false

  - name: top_15_folder_shares_by_folder
    title: Top 15 Folders by Folder Shares
    type: looker_bar
    model: dropbox
    explore: events
    dimensions: [events.folder_name]
    measures: [events.count_folder_shares]
    listen: 
      date: events.event_date
    filters:
      events.is_folder_event: 'Yes'
    sorts: [events.count_folder_shares desc]
    limit: 15
    stacking: ''
    colors: ['#5245ed', '#ed6168', '#1ea8df', '#353b49', '#49cec1', '#b3a0dd', '#db7f2a',
      '#706080', '#a2dcf3', '#776fdf', '#e9b404', '#635189']
    show_value_labels: false
    label_density: 25
    legend_position: right
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
  
  - name: folder_metrics
    title: Folder Metrics
    type: table
    model: dropbox
    explore: events
    dimensions: [events.folder_name]
    measures: [events.count_folder_shares, events.count_folder_joins]
    filters:
      events.is_folder_event: 'Yes'
    sorts: [events.count_folder_shares desc]
    limit: 500
    show_view_names: false
    show_row_numbers: true
    truncate_column_names: false
    table_theme: gray
    limit_displayed_rows: false


  - name: group_to_group_share_bar
    title: Top 15 Group to Group Folder Sharing by Invite Count (inc. No Group specified)
    type: looker_bar
    model: dropbox
    explore: events
    dimensions: [groups.group_name, groups_target.group_name]
    measures: [events.count]
    filters:
      events.event_name: Invited team member(s) to a shared folder
    listen: 
      date: events.event_date
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
  
  - name: group_to_group_folder_table
    title: Group to Group Folder Sharing by Invite Count 
    type: table
    model: dropbox
    explore: events
    dimensions: [groups.group_name, groups_target.group_name]
    measures: [events.count]
    filters:
      events.event_name: Invited team member(s) to a shared folder
      groups.group_name: -No Group
      groups_target.group_name: -No Group
    listen: 
      date: events.event_date
    sorts: [events.count desc]
    limit: 500
    show_view_names: false
    show_row_numbers: true
    truncate_column_names: false
    series_labels:
      events.count: Invite Count
    table_theme: gray
    limit_displayed_rows: false
  
  - name: top_15_links
    title: Top 15 Links by Downloads and Opens
    type: looker_bar
    model: dropbox
    explore: events
    dimensions: [events.info_base_name]
    measures: [events.count, events.count_link_downloads, events.count_link_opens]
    hidden_fields: [events.count]
    listen: 
      date: events.event_date
    filters:
      events.is_link_event: 'Yes'
    sorts: [events.count desc]
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
  
  - name: links_by_downloads_and_opens
    title: Links by Downloads and Opens
    type: table
    model: dropbox
    explore: events
    dimensions: [events.info_base_name]
    measures: [events.count_link_downloads, events.count_link_opens, events.count]
    listen: 
      date: events.event_date
    filters:
      events.is_link_event: 'Yes'
    sorts: [events.count desc]
    limit: 15
    column_limit: 50
    show_view_names: false
    show_row_numbers: true
    truncate_column_names: false
    series_labels:
      events.count: Total Events
    table_theme: gray
  limit_displayed_rows: false




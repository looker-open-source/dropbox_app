- connection: dropbox_looker

- include: "*.view.lookml"       # include all the views
- include: "*.dashboard.lookml"  # include all the dashboards

- explore: files

- explore: groups

- explore: sanitized_events


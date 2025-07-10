#!/bin/bash

summary_file="./summary.txt"
html_file="./report.html"

cat <<EOF > "$html_file"
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>System Report</title>
  <style>
    body { font-family: monospace; background: #f5f5f5; padding: 20px; }
    h1 { color: #333; }
    pre {
      background: #fff;
      border: 1px solid #ccc;
      padding: 15px;
      overflow-x: auto;
    }
  </style>
</head>
<body>
  <h1>System Summary Report</h1>
  <pre>
$(cat "$summary_file")
  </pre>
</body>
</html>
EOF

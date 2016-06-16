<!DOCTYPE html>
<html lang="en">
<head>
    <style>
        table {
            border-collapse: collapse;
        }
        table, th, td {
            border: 1px solid black;
        }
        tr:nth-child(even) {background-color: #f2f2f2 }
    </style>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>{{ title }}</title>
</head>
<body>
<h1>{{ title }}</h1>
<table id="data" border="1px solid black">
    <tr>
        <th>Category</th>
        <th>Value</th>
    </tr>
% for key, value in data.iteritems():
    <tr>
        <td>{{ key }}</td>
        <td>{{ value }}</td>
    </tr>
% end
</table>
<p>{{data}}.</p>
</body>
</html>


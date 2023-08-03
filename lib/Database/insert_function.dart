initInsert(String tableName, Map<String, dynamic> row) {
  String fieldNames = "";
  String fieldValues = "";
  row.forEach((n, v) {
    fieldNames += n + ',';
    if (v is DateTime) {
      fieldValues += "${v == null ? null : "'" + sqlDateTime(v) + "'"},";
    } else if (v is String) {
      fieldValues +=
      "${v == null ? null : "'" + v.replaceAll("'", "''") + "'"},";
    } else {
      fieldValues += "$v,";
    }
  });

  fieldNames = strSlice(fieldNames);
  fieldValues = strSlice(fieldValues);

  return "  $tableName($fieldNames) values ($fieldValues) ";
}

/// Convert a DateTime to a string suitable by MS-SQL commands
String sqlDateTime(DateTime d) {
  String r = d.toString();
  r = r.substring(0, r.length - 4);
  if (r.endsWith(".")) {
    r += "0";
  }
  return r;
}

String strSlice(String s, [int num = 1]) {
  return isEmpty(s) ? "" : s.substring(0, s.length - 1);
}
isEmpty(String s) {
  if (s.isEmpty) return true;
  return false;
}
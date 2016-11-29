
define rsnapshot::exclude(
  $path = $title,
  $rsnapshot_include_file = $rsnapshot::params::rsnapshot_include_file,
) {
  $line = "exclude\t${path}"

  file_line { $line:
    path => $rsnapshot_include_file,
    line => $line,
  }
}

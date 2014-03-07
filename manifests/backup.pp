
class rsnapshot::backup(
  $path = $rsnapshot::params::backup_path,
  $host = $rsnapshot::params::backup_host,
  $user = $rsnapshot::params::backup_user,
  $rsnapshot_include_file = $rsnapshot::params::rsnapshot_include_file,
) inherits rsnapshot::params {

  if ($host) {
    if ($user) {
      $target = "$user@$host:$path"
    } else {
      $target = "$host:$path"
    }
    $dest = $host
  } else {
    $target = $path
    $dest = 'localhost'
  }

  $line = "backup\t$target\t\t$dest"

  file_line { $line:
    path => $rsnapshot_include_file,
    line => $line,
  }

}

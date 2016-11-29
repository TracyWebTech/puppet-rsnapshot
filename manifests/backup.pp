
define rsnapshot::backup (
  $path,
  $host = $rsnapshot::params::backup_host,
  $user = $rsnapshot::params::backup_user,
  $rsnapshot_include_file = $rsnapshot::params::rsnapshot_include_file,
) {

  validate_re($path, ['/$'], "\$path must end with a trailing slash [${host}:${path}]")

  if ($host) {
    if ($user) {
      $target = "${user}@${host}:${path}"
    } else {
      $target = "${host}:${path}"
    }
  } else {
    $target = $path
  }

  if($dest) {
    $store = $dest
  } else {
    if($host) {
      $store = $host
    } else {
      $store = 'localhost'
    }
  }

  $line = "backup\t${target}\t\t${store}/"

  file_line { $line:
    path => $rsnapshot_include_file,
    line => $line,
  }

}

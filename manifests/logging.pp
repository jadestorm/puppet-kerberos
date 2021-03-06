# This defines logging entries in the Kerberos config
define kerberos::logging (
  $key   = 'default',
  $value = 'SYSLOG'
) {

  validate_re($key,[
    '^default$',
    '^kdc$',
    '^admin_server$'
  ] )
  validate_re($value, [
    '^FILE[=|:].*$',
    '^STDERR$',
    '^CONSOLE$',
    '^DEVICE=.*$',
    '^SYSLOG(:.*)?$'
  ] )

  $order_name = regsubst($name, '\W', '')

  concat::fragment{"krb5_${name}_logging":
    target  => 'krb5_config',
    content => "  ${key} = ${value}\n",
    order   => "02${order_name}"
  }

}
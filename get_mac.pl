#!/usr/bin/perl 
# Nick created at AMAX on 2020/04/24
use strict;
use warnings;
use DBD::mysql;


my $num2 = '$2';
my $boot_mac = `ifconfig -a | grep -A2 10.10.10  | grep ether | awk -F " " {'print $num2'} | sed -e 's/:/-/g'`;
chomp $boot_mac;  # rm \n

my $dsn = "DBI:mysql:database=image:host=10.10.10.1:port='3306'";
my $dbh = DBI->connect($dsn, 'img', 'rootroot');


# check list

print "Check the boot mac in record to get IP settings.!\n\n";

my  $s1th = $dbh->prepare('SELECT bootmac FROM macip where bootmac=?');
 $s1th->execute($boot_mac);
 (my $oldre) = $s1th->fetchrow_array() || '0';

## register if no record
if ( not $oldre){
    print "No record found\nRegister now\n\n";
    my $s1th = $dbh->prepare('INSERT INTO macip ( bootmac ) VALUES (?)');
    $s1th->execute($boot_mac);
    $s1th->finish;
}
else
{
    print "Found records, conitnue\n";
}
sleep 10;
__END__
mysql> desc macip

 bootmac     | varchar(45) | NO   | PRI | NULL    |       |
| ip          | varchar(45) | YES  |     | NULL    |       |
| netmask     | varchar(45) | YES  |     | NULL    |       |
| gateway     | varchar(45) | YES  |     | NULL    |       |
| dns         | varchar(45) | YES  |     | NULL    |       |
| ipmiip      | varchar(45) | YES  |     | NULL    |       |
| ipminetmask | varchar(45) | YES  |     | NULL    |       |
| ipmigateway | varchar(45) | YES  |     | NULL    |       |


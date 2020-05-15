#!/usr/bin/perl 
# Nick created at AMAX on 2020/04/24
use strict;
use warnings;
use POSIX qw(strftime);
use File::Copy;
use Net::IP;
use DBD::mysql;
use Path::Tiny qw(path);
use Log::Log4perl qw(:easy);

=head2 boot_mac
Get the boot device MAC address for legacy/Grub boot menu
=cut

sub boot_mac(){
  my $num2 = '$2';
  my $boot_mac = `ifconfig -a | grep -A2 10.10.10  | grep ether | awk -F " " {'print $num2'} | sed -e 's/:/-/g'`; 
}

=head2 mb_sn
Get the motherboard sn
=cut

sub mb_sn(){
    my $sn = `dmidecode  -s baseboard-serial-number`;
}

=head2 ipmi_mac
Get the ipmi mac
=cut

sub ipmi_mac(){
    my $num4 = '$4';
    my $vendor = `dmidecode -s  baseboard-manufacturer`;
    return my $ipmi_mac = `ipmitool lan print 3 | grep -i "MAC Address" | awk -F " "  '{print $num4}' | sed -e 's/://g'` if  $vendor =~ /Intel/i; 
    $ipmi_mac = `ipmitool lan print 1 | grep -i "MAC Address" | awk -F " "  '{print $num4}' | sed -e 's/://g'` if  $vendor =~ /Super/i;
}

=head2 all_mac
Get all the mac address list, separated by comma
=cut

sub all_mac(){
    my $cmd = 'for  i in `ls /sys/class/net/`;do cat /sys/class/net/$i/address;done';
    my @all_mac = `$cmd`;
    pop @all_mac;
    chomp @all_mac;
    my $all_mac = join ", ", @all_mac;
}

=head2 trace
log tools, for future use
=cut

sub trace(){
     (my $log, my $content) = @_;
     my $datestring = strftime "%Y-%m-%d %H:%M:%S", localtime; 
}

=head2 mkpxemenu
generate the pxe boot menu files, legacy/grub.
=cut

sub mkpxemenu{
    (my $bootmac) = @_; 
    #unlink /home/data/pxelinux.cfg/$bootmac if -f (/home/data/pxelinux.cfg/$bootmac);
    copy("/home/data/pxelinux.cfg/pxelinux.cfg","/home/data/pxelinux.cfg/01-$bootmac") or die "Copy failed: $!"; 
    my $menu = "/home/data/pxelinux.cfg/01-$bootmac";
    # ks-ac-1f-6b-a1-19-8a.cfg 
    my $file = path($menu);   
    my $data = $file->slurp_utf8;
    $data =~ s/ks.cfg/ks-$bootmac.cfg/g;
    $file->spew_utf8( $data );
    system ("/home/data/img/scp.sh $menu /tftpboot/nbi_img/pxelinux.cfg/");
    ## uefi grub menu
    copy("/home/data/grub/grub.cfg","/home/data/grub/grub.cfg-01-$bootmac") or die "Copy Grub menu failed: $!"; 
    my $grubmenu = "/home/data/grub/grub.cfg-01-$bootmac";
    # /home/data/grub
    my $gfile = path($grubmenu);
    my $gdata = $gfile->slurp_utf8;
    $gdata =~ s/ks.cfg/ks-$bootmac.cfg/g;
    $gfile->spew_utf8( $gdata );
    system ("/home/data/img/scp.sh $grubmenu /tftpboot/nbi_img/grub-efi.cfg/");
    # copy("/home/data/pxelinux.cfg/$bootmac",$log);
    1;
}

=head2 set_ipmi
set the ipmi ip
=cut

sub set_ipmi{
  (my $ipmi_ip, my $inetmask, my $igateway, my $iuser, my $ipass) = @_;
  print "Clear BMC setting now!";
  system ("/usr/bin/syscfg/syscfg /rfs");
  #system ("/usr/bin/syscfg/syscfg /rbmc");
  print "sleep 1 min to waiting bmc reset.%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%";
  sleep 60;
  system ("ipmitool lan set 3 ipsrc static 2&>/dev/null "); 
  if ($? != 0){
      return 0; 
  }
  system ("ipmitool lan set 3 ipaddr $ipmi_ip "); 
  system ("ipmitool lan set 3 netmask $inetmask "); 
  system ("ipmitool lan set 3 defgw ipaddr  $igateway "); 
  system ("ipmitool user set name 2 $iuser "); 
  system ("ipmitool user set password 2 $ipass "); 
  system ("ipmitool user priv 2 4 3"); 
  system ("ipmitool user enable 2"); 
  1;
}

=head2 mk_ks
generate the ks files
=cut

sub mk_ks{
  # $boot_mac, $hip->ip(), $config->{netmask}, $config->{gateway}, $config->{dns}
  (my $bootmac, my $hostip, my $netmask, my $gateway, my $dns, my $hostname, my $osrootpw, my $osuser, my $osuserpw)  = @_;
  my $ks = 'ks-'."$bootmac".'.cfg';
  copy("/home/data/ks.cfg","/home/data/ks/$ks") or die "Copy failed: $!";    
  my $ksfile = "/home/data/ks/$ks";
  my $file = path($ksfile);
  my $data = $file->slurp_utf8;
  # --gateway= --nameserver= --netmask=
  $data =~ s/--ip=/--ip=$hostip/g;
  $data =~ s/--netmask=/--netmask=$netmask/g;
  $data =~ s/--gateway=/--gateway=$gateway/g;
  $data =~ s/--nameserver=/--nameserver=$dns/g;
  $data =~ s/OShostname/$hostname/g;
  $data =~ s/osrootpw/$osrootpw/g;
  $data =~ s/osuser/$osuser/g;
  $data =~ s/osUserpw/$osuserpw/g;
  # eno1
  $data =~ s/IPADDR=/IPADDR=$hostip/g;
  $data =~ s/NETMASK=/NETMASK=$netmask/g;
  $data =~ s/GATEWAY=/GATEWAY=$gateway/g;
  $data =~ s/DNS1=/DNS1=$dns/g;
  $file->spew_utf8( $data );
  system ("/home/data/img/scp.sh /home/data/ks/$ks /tftpboot/nbi_img/image/CentOS-7-x86_64-DVD-1708/ks/");
}

=head2 IMG_ENV
Read from config file
=cut

sub IMG_ENV {
    (my $config ) = @_;    
    my %img_env;
    open CONFIG, "<", $config 
        or die("Cannot read config file " . $config);
    while (<CONFIG>) {
        # skip blank lines
        next if /^\s*$/;

        # skip comments
        next if /^\s*#/;

        # parse line like 'key = "value"'
        /^\s*([\w_.-]+)\s*=\s*"([~\w,:\/;._\s\d!=-]*)"/;
        my ($key, $value) = ($1, $2);
        if (!$key && !$value || !defined($value)) {
            die "Can't parse config file " . $config . " line ${.}. Ignoring."; 
            next;
        }

        # values with commas will be split and each item parsed
        if ($value =~ /,|=/) {
            for my $item (split /,/, $value) {
                # skip empty values
                next unless $item;

                if ( $item =~ /([\w_.\d\/:-]+)\s*=\s*([\w_.\d\/:-]*)/ ) {
                    # turn 'foo = "bar=jazz,blah=grub"' into 
                    #  $img_env{foo} = { "bar" => "jazz", "blah" => "grub" }
                    $img_env{$key}{$1} = $2;
                } else {
                    # turn 'foo = "bar,blah,grub" into 
                    #  $img_env{foo} = ( "bar", "blah", "grub" );
                    push @{$img_env{$key}}, $item;
                }
            }
        } else {
            # regular 'key = "value"' line
            $img_env{$key} = $value;
        }
    } 

    # mark config file as read
    my $config_read = 1;
    close CONFIG or trap("Cannot close config file " . $config);

    # return reference to config data
    return \%img_env;
}

=head1 main
main sub
=cut

sub main() {
    my $logconf = q(
        log4perl.logger  = INFO, Logfile, Screen
        log4perl.appender.Logfile          = Log::Log4perl::Appender::File
        log4perl.appender.Logfile.filename = LOGFILE
        log4perl.appender.Logfile.layout   = Log::Log4perl::Layout::PatternLayout
        log4perl.appender.Logfile.layout.ConversionPattern = [%6r] %5p %L %d %C:   %m%n
        log4perl.appender.Screen         = Log::Log4perl::Appender::Screen
        log4perl.appender.Screen.stderr  = 0
        log4perl.appender.Screen.layout = Log::Log4perl::Layout::SimpleLayout
    );

    chomp (my $boot_mac = boot_mac());  
    my $chompmac = $boot_mac;
    $chompmac =~ s/-//g;
    chomp (my $mb_sn = mb_sn());
    chomp (my $ipmi_mac = ipmi_mac());
    my $datestring = strftime "%Y-%m-%d_%H:%M:%S", localtime;
    my $logfile = '/home/data/log/' . $mb_sn . '-' . $boot_mac . '-' . $datestring . '.log';
    our $logger = get_logger();
    $logconf =~ s/LOGFILE/$logfile/;
    Log::Log4perl::init( \$logconf );

    # Log config
    # [1] logtest.pl 21 2020/04/29 15:00:59 main:   Drinking Tee
    my $mac_list = all_mac();
    
    $logger->info("╔══╗                 ╔═══╗         ╔═╗      ");
    $logger->info("╚╣╠╝                 ║╔═╗║         ║╔╝      ");
    $logger->info(" ║║ ╔╗╔╗╔══╗ ╔══╗╔══╗║║ ╚╝╔══╗╔═╗ ╔╝╚╗╔╗╔══╗");
    $logger->info(" ║║ ║╚╝║╚ ╗║ ║╔╗║║╔╗║║║ ╔╗║╔╗║║╔╗╗╚╗╔╝╠╣║╔╗║");
    $logger->info("╔╣╠╗║║║║║╚╝╚╗║╚╝║║║═╣║╚═╝║║╚╝║║║║║ ║║ ║║║╚╝║");
    $logger->info("╚══╝╚╩╩╝╚═══╝╚═╗║╚══╝╚═══╝╚══╝╚╝╚╝ ╚╝ ╚╝╚═╗║");
    $logger->info("             ╔═╝║                       ╔═╝║");
    $logger->info("             ╚══╝                       ╚══╝");
    $logger->info("logfile is $logfile");
    $logger->info("Boot mac is: $boot_mac"); 
    $logger->info("Chomp mac is: $chompmac"); 
    $logger->info("MB SN is : $mb_sn");
    $logger->info("IPMI MAC : $ipmi_mac");
    $logger->info("MAC List : $mac_list");
    
    # confige file
    my $config_file = '/home/data/img/IMG.conf';
    my $config = IMG_ENV ('/home/data/img/IMG.conf');
    # Connect DB
    my $dsn = "DBI:mysql:database=$config->{db_name}:host=$config->{db_host}:port='3306'";
    my $dbh = DBI->connect($dsn, $config->{db_user}, $config->{db_pass});

    # delete record
    my $s1th = $dbh->prepare('DELETE FROM unitlist where mbsn=?');
    $s1th->execute($mb_sn);
    $s1th->finish;

    # get all the info(ip, dns, hostname, etc.....)  
    my %getconf;
    my @macipcols = qw/bootmac hostname ip netmask gateway dns osrootpw osuser osuserpw ipmiip ipminetmask ipmigateway ipmiuser ipmipasswd/;
    $s1th = $dbh->prepare('SELECT * FROM macip where bootmac=?');
    $s1th->execute($chompmac);
    @getconf{@macipcols} = $s1th->fetchrow_array();
    $s1th->finish;
 

    print "################DEBUG###############################\n";
    for my $key (keys %getconf) {
        $logger->fatal("Macinfo has blank setting! Please check!!") && die "Blank info in macip setting!" unless $getconf{$key}; 
    }    
    print "################DEBUG###############################\n";
    sleep 2;

    mkpxemenu($boot_mac); ## create the PXE menu
    $logger->info("*************Boot menu is setup now.");
   
    $logger->info("Hostname: " . $getconf{hostname});
    $logger->info("Host IP: " . $getconf{ip});
    $logger->info("netmask: " . $getconf{netmask});
    $logger->info("gateway: " . $getconf{gateway});
    $logger->info("dns: " . $getconf{dns});
    $logger->info("osrootpw: " . $getconf{osrootpw});
    $logger->info("osuer: " . $getconf{osuser});
    $logger->info("osuserpw: " . $getconf{osuserpw});
    $logger->info("\n");
    $logger->info("IPMI IP: " . $getconf{ipmiip});
    $logger->info("IPMI netmask: " .  $getconf{ipminetmask});
    $logger->info("IPMI gateway: " .  $getconf{ipmigateway});
    $logger->info("IPMI user: " .  $getconf{ipmiuser});
    $logger->info("IPMI passwd: " .  $getconf{ipmipasswd});
    
    # set ipmi addr
    ##my $revl = set_ipmi($getconf{ipmiip}, $getconf{ipminetmask}, $getconf{ipmigateway}, $getconf{ipmiuser}, $getconf{ipmipasswd});
    ##if ($revl) {
    ##    $logger->info("*************IPMI IP is set done now.");
    ##}
    ##else{
    ##    $logger->error("*************IPMI IP failed.");
    ##}
    # prepare ks.cfg
    mk_ks($boot_mac, $getconf{ip} , $getconf{netmask}, $getconf{gateway}, $getconf{dns}, $getconf{hostname}, $getconf{osrootpw},$getconf{osuser},$getconf{osuserpw});
    $logger->info("*************ks.cfg for boot mac is  done now.");
    # Register unit to db
    $logger->info("*************Register this unit now.\n");
   
    ##
    
    $s1th = $dbh->prepare('select mbsn from unitlist where mbsn=?');
    $s1th->execute($mb_sn);
    (my $sn) = $s1th->fetchrow_array() || 'no';
    $logger->info("############MBSN recorded in DB  count is $sn now");
    $logger->info("############This host mb_sn is $mb_sn");
    $s1th->finish;
    if ( $sn ne $mb_sn) {
        $logger->info("*************No record found, register!");      
        my $s1th = $dbh->prepare('INSERT INTO unitlist (mac, mbsn, ipmimac, allmaclist, hostname, ip, netmask, gateway, dns, osrootpw, osuser, osuserpw, ipmiip, ipminetmask, ipmigateway, ipmiuser, ipmipasswd) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)');
        $s1th->execute( $boot_mac, $mb_sn, $ipmi_mac, $mac_list, $getconf{hostname}, $getconf{ip}, $getconf{netmask}, $getconf{gateway}, $getconf{dns}, $getconf{osrootpw}, $getconf{osuser}, $getconf{osuserpw}, $getconf{ipmiip}, $getconf{ipminetmask}, $getconf{ipmigateway}, $getconf{ipmiuser}, $getconf{ipmipasswd});
        $s1th->finish;
        $logger->info("*************Register done now.");
    } else {
        $logger->info("*************Registered already.");
    }
    #$logger->fatal("Done");
    sleep 15;
}

main();

__END__
host:localhost
user:img
passwd:rootroot
db:img
tb:unitlist
row:
+------------+-------------+------+-----+---------+----------------+
| Field      | Type        | Null | Key | Default | Extra          |
+------------+-------------+------+-----+---------+----------------+
| id         | int         | NO   | PRI | NULL    | auto_increment |
| mbsn       | varchar(45) | YES  |     | blanksn |                |
| mac        | varchar(45) | NO   | UNI | NULL    |                |
| ipmimac    | varchar(45) | NO   | UNI | NULL    |                |
| allmaclist | varchar(45) | NO   |     | NULL    |                |
| ip         | varchar(45) | NO   | UNI | NULL    |                |
| ipmiip     | varchar(45) | NO   | UNI | NULL    |                |
+------------+-------------+------+-----+---------+----------------+
Config now!
Boot mac is: ac-1f-6b-a1-19-8a
mb sn is : UM196S005458
ipmi mac : ac1f6ba1c6d2
logfile is /home/data/log/UM196S005458-ac-1f-6b-a1-19-8a-2020-04-22_22:10:58.log
maclist : ac:1f:6b:a1:19:8a, ac:1f:6b:a1:19:8b
###############################################################################
# configfile
my $config = IMG_ENV ('/home/data/img/IMG.conf');
#print $config->{db_pass} . "\n";
for (sort keys %{ $config }) {
    print "$_ => ${ $config }{$_}\n";
    }
db_host => 10.10.10.1
db_name => image
db_pass => rootroot
db_tb => unitlist
db_user => root
dns => 8.8.8.8
gateway => 192.168.0.254
igateway => 192.168.101.254
iip_start => 192.168.101.1
inetmask => 255.255.255.0
ip_start => 192.168.0.1
iqty => 250
netmask => 255.255.255.0
qty => 25

#################################################################################
# table: macip
# my @columns = qw/bootmac hostname ip netmask gateway dns osrootpw osuser osuserpw ipmiip ipminetmask ipmigateway ipmiuser ipmipasswd/;

use strict;
use warnings;
use GD::Graph::bars;

$ARGV[0] or die;
my $arg=$ARGV[0];
chomp($arg);
$arg=~s/'//g;

my $s=join("","Ser/file",$arg,".txt");

open(FILE,"<",$s);
my @lines=<FILE>;
my $size=scalar(@lines);
chomp(@lines);
close(FILE);

my @x_axis=(1..$size);

my @y_axis; 

foreach (@lines) {
	my @row=split(",",$_);
	push(@y_axis,$row[0]);
}

my $my_graph = GD::Graph::bars->new(500, 300);

$my_graph->set( 
		x_label           => 'Time',
   		y_label           => 'Price',
    		title             => 'Serial Price Graph',
   		dclrs=>[qw(lblue)],
 		) or die $my_graph->error;

my @data=(\@x_axis,\@y_axis);
my $gd = $my_graph->plot(\@data) or die $my_graph->error;

#my $fs="file.png";
my $fs=join("","Ser/fz",$arg,".png");

open(IMG,">",$fs) or die $!;
binmode IMG;
print IMG $gd->png;
close IMG;

my $text="open -a Preview ";
$text.=$fs;
system($text);

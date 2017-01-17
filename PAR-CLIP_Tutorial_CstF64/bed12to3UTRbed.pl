#!/usr/local/bin/perl
#Title: Make 3UTR bed format data
#Auther: Naoto Imamachi
#ver: 1.0.0
#Date: 2014-11-17

=pod
=cut

use warnings;
use strict;

my $usage = "Usage: $0 <bed12 file> <bed6 3UTR file> <non-3UTR file>\n";
my ($input,$output,$non) = @ARGV or die $usage;

#MAIN################################
open(IN,"<$input") || die;
open(OUT,">$output") || die;
open(NON,">$non") || die;

my $count = 0;

while(my $line = <IN>){
	chomp $line;
	my @data = split/\t/,$line;
	my $chr = $data[0];
	my $st = $data[1];
	my $ed = $data[2];
	my $name = $data[3];
	my $score = $data[4];
	my $str = $data[5];
	my $ORF_st = $data[6];
	my $ORF_ed = $data[7];
	if($str eq "+" && $ed == $ORF_ed && $ORF_st != $ORF_ed){ #Protein-coding & non-3UTR
		print NON "$line\n";
		$count++;
		next;
	}
	if($str eq "-" && $st == $ORF_st && $ORF_st != $ORF_ed){
		print NON "$line\n";
		$count++;
		next;
	}
	if($ORF_st == $ORF_ed){ #non-ORF, non-coding
		print OUT "$line\n";
		next;
	}
	my $flg=0;
	my $UTR_st;
	my $UTR_ed;
	if($str eq "+"){ ##OK##
		my @exon_length = split/,/,$data[10];
		my @exon_st = split/,/,$data[11];
		my @UTR_exon_length;
		my @UTR_exon_st;
		
		for(my $i=0; $i<@exon_length; $i++){
			my $st_exon = $st + $exon_st[$i];
			my $ed_exon = $st + $exon_length[$i] + $exon_st[$i];
			if($flg == 1){ #multi-3UTR
				my $UTR_exon_st_new = $st_exon - $ORF_ed;
				my $UTR_exon_length_new = $exon_length[$i];
				push(@UTR_exon_st,$UTR_exon_st_new);
				push(@UTR_exon_length,$UTR_exon_length_new);
				next;
			}elsif($flg == 2){ #the end of exon => the end of ORF...
				my $UTR_exon_st_new = 0;
				my $UTR_exon_length_new = $exon_length[$i];
				$UTR_st = $st_exon;
				push(@UTR_exon_st,$UTR_exon_st_new);
				push(@UTR_exon_length,$UTR_exon_length_new);
				$flg = 3;
			}elsif($flg == 3){ #the end of exon => the end of ORF... & multi-3UTR
				my $UTR_exon_st_new = $st_exon - $UTR_st;
				my $UTR_exon_length_new = $exon_length[$i];
				push(@UTR_exon_st,$UTR_exon_st_new);
				push(@UTR_exon_length,$UTR_exon_length_new);
				next;
			}
			if($st_exon < $ORF_ed && $ed_exon > $ORF_ed){ #normal
				my $UTR_exon_st_new = 0;
				my $UTR_exon_length_new = $ed_exon - $ORF_ed;
				push(@UTR_exon_st,$UTR_exon_st_new);
				push(@UTR_exon_length,$UTR_exon_length_new);
				$flg = 1;
				next;
			}elsif($ed_exon == $ORF_ed){ #the end of exon => the end of ORF...
				$flg = 2;
				next;
			}
		}
		my $number = @UTR_exon_length;
		if($flg == 2 || $flg == 3){
			print OUT "$chr\t$UTR_st\t$ed\t$name\t$score\t$str\t$ed\t$ed\t$data[8]\t$number\t";
			print OUT join(",",@UTR_exon_length),",\t",join(",",@UTR_exon_st),",","\n";
			next;
		}
		print OUT "$chr\t$ORF_ed\t$ed\t$name\t$score\t$str\t$ed\t$ed\t$data[8]\t$number\t";
		print OUT join(",",@UTR_exon_length),",\t",join(",",@UTR_exon_st),",","\n";
	}elsif($str eq "-"){
		my @exon_length = split/,/,$data[10];
		my @exon_st = split/,/,$data[11];
		my @UTR_exon_length;
		my @UTR_exon_st;
		for(my $i=0; $i<@exon_length; $i++){
			my $st_exon = $st + $exon_st[$i];
			my $ed_exon = $st + $exon_length[$i] + $exon_st[$i];
			if($st_exon < $ORF_st && $ed_exon > $ORF_st && $flg == 1){ #multi-3UTR (last)
				my $UTR_exon_st_new = $exon_st[$i];
				my $UTR_exon_length_new = $ORF_st - $st_exon;
				push(@UTR_exon_st,$UTR_exon_st_new);
				push(@UTR_exon_length,$UTR_exon_length_new);
				last;
			}
			if($st_exon < $ORF_st && $ed_exon > $ORF_st && $flg == 0){ #normal
				my $UTR_exon_st_new = 0;
				my $UTR_exon_length_new = $ORF_st - $st_exon;
				push(@UTR_exon_st,$UTR_exon_st_new);
				push(@UTR_exon_length,$UTR_exon_length_new);
				last;
			}elsif($st_exon == $ORF_st){ #the start of exon => the start of ORF...
				$flg = 2;
				last;
			}elsif($st_exon < $ORF_st && $ed_exon < $ORF_st){ #multi-3UTR(first-)
				my $UTR_exon_st_new = $exon_st[$i];
				my $UTR_exon_length_new = $exon_length[$i];
				$UTR_ed = $ed_exon;
				push(@UTR_exon_st,$UTR_exon_st_new);
				push(@UTR_exon_length,$UTR_exon_length_new);
				$flg = 1;
				next;
			}
		}
		my $number = @UTR_exon_length;
		if($flg == 2 && $str eq "-"){
			print OUT "$chr\t$st\t$UTR_ed\t$name\t$score\t$str\t$UTR_ed\t$UTR_ed\t$data[8]\t$number\t";
			print OUT join(",",@UTR_exon_length),",\t",join(",",@UTR_exon_st),",","\n";
			next;
		}
		print OUT "$chr\t$st\t$ORF_st\t$name\t$score\t$str\t$ORF_st\t$ORF_st\t$data[8]\t$number\t";
		print OUT join(",",@UTR_exon_length),",\t",join(",",@UTR_exon_st),",","\n";
	}
}

print "non-3UTR: $count\n";

close(IN);
close(OUT);
close(NON);

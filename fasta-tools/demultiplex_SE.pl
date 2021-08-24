#!/usr/bin/perl -w

# Forked from Chris Hollenbeck's demultiplex.pl to add a flag for single-end reads

use strict;
use Getopt::Long;
use Pod::Usage;
use Data::Dumper;

pod2usage(-verbose => 1) if @ARGV == 0;

my $infofile = '';
my $outfile = '';
my $projdir = '';
my $datadir = '';
my $miseq = '';
my $enz_1 = 'sphI';
my $enz_2 = 'ecoRI';
my $single = '';

GetOptions(	'infofile|i=s' => \$infofile,
			'outfile|o=s' => \$outfile,
			'project_dir|p=s' => \$projdir,
			'data_dir|d=s' => \$datadir,
			'miseq|m' => \$miseq,
			'enz_1|e1=s' => \$enz_1,
			'enz_2|e2=s' => \$enz_2,
			'single|se' => \$single
			);

#if (! $sampdir) {
#	warn "Please specify the name of a directory to which your script will write sample files\n";
#	pod2usage(-verbose => 1);
#}

if (! $projdir) {
	warn "Please specify the name of a directory from which your script will run\n";
	pod2usage(-verbose => 1);
}

open(IN, "<", $infofile) or die $!;

# Read in the sample name, barcode, and index for each individual
# The info file should be a tab-separated file (with no spaces in individual field names) formatted as:
#
#	sample_name		barcode_sequence	index_sequence
#
# i.e.
#
#	Samp_001	ACTAT	ATCACG
#	Samp_002	ATTAC	ATCACG
#	...

my %data;
my @sample_info;
while(<IN>) {
	next if $_ =~ /^\s/;
	chomp;
	my @info = split;
	$data{$info[2]}{$info[0]} = $info[1];
	push @sample_info, \@info;
}
close IN;

# Check the data directory to find the names of the raw files for each index

opendir(DIR, $datadir) or die $!;
my @datafiles;
if ($miseq) {
	@datafiles = grep(/_R[12]_/, readdir DIR);
} else {
	@datafiles = grep(/fastq\.gz$/ || /fq\.gz$/, readdir DIR);
}

my @indices = keys %data;

if ($single) {
	if (scalar(@datafiles) != 1 * scalar(@indices)) {
	warn "Not reading datafiles correctly\n";
	}
}	else {
	if (scalar(@datafiles) != 2 * scalar(@indices)) {
	warn "Not reading datafiles correctly\n";
	}
}

# Map datafiles to indices
my %data_map;
foreach my $file (@datafiles) {
	my $index;
	my $direction;
	if ($file =~ /([ATCG]{6})/) {
		$index = $1;
	} elsif ($miseq) {
		if (scalar(keys %data == 1)) {	
			my @miseq_index = keys %data;
			$index = $miseq_index[0];
		} else {
			warn "Detecting multiple indices for miseq data - you will have to code the files manually\n";
		}
	}
	if ($file =~ /[_\.](R1)[_\.]/ || $file =~ /[_\.]([1])[_\.]/ || $file =~ /[_\.]([F])[_\.]/) {
		$direction = 'F';
	} elsif ($file =~ /[_\.](R2)[_\.]/ || $file =~ /[_\.]([2])[_\.]/ || $file =~ /[_\.]([R])[_\.]/) {
		$direction = 'R';
	} else {
		warn "Cannot determine which data files are forward and reverse\n";
	}
	
	if (! $index || ! $direction) {
		print "Unable to identify the data files that match the index sequences: dumping the contents of the data directory to \'datadir.txt\'\n";
		open(DFILE, ">", 'datadir.txt');
		foreach my $datafile (@datafiles) {
			print DFILE $datafile, "\n";
		}
		foreach my $ind (@indices) {
			$data_map{$ind}{'F'} = "${ind}_forward.fq.gz";
			$data_map{$ind}{'R'} = "${ind}_reverse.fq.gz";
		}
		last;
	}
	
	
	$data_map{$index}{$direction} = $file;
	
}

#print "@datafiles\n";


open(DUMP, ">", 'dumper.out');
print DUMP Dumper(\%data);

open(SAMP, ">", $outfile) or die $!;

print SAMP "#!/bin/bash\n\n";
print SAMP "src=$projdir\n";
print SAMP "datadir=$datadir\n";

	foreach my $index (keys %data) {
	open(CODE, ">", $index . '_barcodes.txt') or die $!;
	print SAMP "\n\n\# Process samples from index $index\n\n";
	print SAMP "\# Extracting single-end tags\n\n";
	print SAMP "process_radtags -1 \$datadir/$data_map{$index}{'F'} -2 \$datadir/$data_map{$index}{'R'} -i gzfastq -b ${index}_barcodes.txt -o . --renz_1 $enz_1 --renz_2 $enz_2 -E phred33 -r", "\n\n";
	foreach my $sample (keys %{$data{$index}}) {
	if ($single) {
		print SAMP "mv \$src/sample_" . $data{$index}{$sample} . ".fq.gz \$src/" . $sample . '.F.fq.gz', "\n";
		print CODE $data{$index}{$sample}, "\n";
	}
		else {
		print SAMP "mv \$src/sample_" . $data{$index}{$sample} . ".1.fq.gz \$src/" . $sample . '.F.fq.gz', "\n";
		print SAMP "mv \$src/sample_" . $data{$index}{$sample} . ".2.fq.gz \$src/" . $sample . '.R.fq.gz', "\n";
		print CODE $data{$index}{$sample}, "\n";
	}
}
print SAMP "mv \$src/process_radtags.log \$src/${index}_radtags.log\n";
	close CODE;
}
 
close SAMP;

__END__

=head1 NAME

demultiplex.pl

=head1 SYNOPSIS

perl demultiplex.pl

Options:
     -i     infofile
     -o		outfile
     -p		project_dir
	 -d		data_dir
	 -e1	enzyme_1
	 -e2	enzyme_2
	 -m		miseq
	 -se	single-end

=head1 OPTIONS

=over 8

=item B<-i>	
Tab-delimited file containing sample info with one sample per line:

	sample_name	barcode_sequence	index_sequence

Which would like something like this:

	Samp_001  ACTAT  ATCACG
	Samp_002  ATTAC	 ATCACG

=item B<-o>	
	Name of the batch file to write

=item B<-p>	
	Path to main directory for the analysis

=item B<-d>	
	Path of the directory where the raw data files can be found

=item B<-e1>	
	Name of the enzyme that cut for forward reads (e.g. ecoRI)

=item B<-e2>	
	Name of the enzyme that cut for reverse reads (e.g. ecoRI)

=item B<-m>	
	Use this flag if demultiplexing MiSeq data

=item B<-se>	
	Use this flag if demultiplexing single-end reads

** Additionally, IGNORE any prompts about erroneous "." **

=back

=head1 DESCRIPTION

B<demultiplex.pl> takes a tab-delimited textfile with sample barcode and index information and writes a batch
 file (and barcode information file) for process_radtags to process the samples and rename them in dDocent-compatible fashion

=cut


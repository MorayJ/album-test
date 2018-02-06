use strict;
use warnings;
use REST::Client;
use JSON;
use List::Util qw(max);

my $host = "https://jsonplaceholder.typicode.com";

    my $client = REST::Client->new(
	host => $host,
	timeout => 10,
    );

$client->GET('albums');

if ($client->responseCode != 200) {

    die "Check that you are connected to the internet and that the data is still available at the location\n";
    
} else {

    my $albums_array = decode_json($client->responseContent());

    die "Please check changes to the data source" unless ref $albums_array eq 'ARRAY';
    
    my %users;

    my %album_length;

    foreach my $album_hash (@{ $albums_array }) {

	die "Please check changes to the data source" unless ref $album_hash eq 'HASH';
	
	$users{ $$album_hash{'userId'} }++;
	
	$album_length{ $$album_hash{'title'} } = length($$album_hash{'title'});

    };

    my $users_no = keys %users;
    
    print "User 2 has $users{'2'} albums\n";

    print "There are $users_no users\n";
    
    my $max_title = max values %album_length;

    foreach my $title (keys %album_length) {

	if ($album_length{$title} == $max_title) {

	    print "\"$title\" is the longest title with $max_title characters\n";

	};

    };
    
};

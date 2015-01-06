xlreg_r
=======

A Ruby client for the xlReg cluster registry.  **xlreg_r**
makes it easy to create new small clusters some or all of whose members are
written in the programming language Ruby.  
xlreg_r is expected to be used primarily for testing, where
the ability to create and launch new, unique, distinct clusters in seconds
will be a major advantage.

In such a cluster, members use the **xlReg** public server to register and
exchange member IP addresses.  When a member finishes booting, it has 
learned the IP addresses of its peers and the RSA keys used to encrypt 
traffic between members and traffic between cluster members and clients.

## The xlReg Service

<img src="img/xl-registration.jpg" alt="xl-registration" style="float:left" title="members registering with xlReg">

[xlReg](http://jddixon.github.io/xlReg_go)
is a service which provides its clients with unique nodeIDs and allows them
to register and join new clusters and collect configuration information
about existing clusters.

An **xlReg cluster** is a number of machines
which cooperate as a set of intercommunicating servers.  Each
such server has two RSA keys.  One, the **sig** key, is used for creating
digital signatures.  The other, the **comms** key, is used for encrypting
communications.  Most often the comms key is used for creating keys for
block ciphers. That is, the comms key is used only for agreeing on the
much faster block cipher key used during the rest of the communications
session.

Each xlReg cluster member has at least one IP address used for
intra-cluster communications, for communications between members.  In some
clusters each member will also have a second IP address used for 
communications with cluster clients.

The xlReg server itself, its clients, and so the cluster members all are
or behave like
[XLattice nodes](http://jddixon.github.io/xlNode_go).
That is, they are self-contained fault-tolerant entities with some
persistent store.  These nodes may be located anywhere on the global
Internet, or on private networks with access to the network in which
an xlReg server resides.`

Like any XLattice node, the xlReg client can either be configured with some
specific keys at start-up or it will generate a new pair of keys and save
them to persistent store.

## Registration

<img src="img/simple-cluster.jpg" alt="simple-cluster" style="float:right" title="small cluster, no clients">

A booting xlReg client establishes an encrypted connection to an xlReg server 
(by default this is xlreg.xlattice.net).
If this is the client's first conversation with the xlReg server, the client 
provides the server with configuration information including its RSA public
keys.  (The client does **not** register its secret RSA **private** keys.)
The configuration information is signed with the applicant's private
*sig" key.  The server uses the
client's RSA public key, provided as part of the configuration information, to
verify the client's digital signature on the configuration data.  This proves
that the configuration information is intact and that the applicant has the
private key corresponding to the public key.  In other words, the server has
in a certain sense confirmed the applicant's identity.  Having done this,
the xlReg server issues the client with a unique node ID, a 20-byte value,
completing client registration.

Once an xlReg registry client has identified itself to the registry it can

1. register new clusters or
2. join existing clusters or
3. get information on existing clusters.

The third option is used, for example, by nodes intending to become clients
of an existing cluster.

## Acquiring Configuration Data

After a new member has joined a cluster the server provides it
with cluster configuration data.  This includes

* the cluster name,
* the cluster ID, and
* the cluster size, the  maximum number of cluster members

It also includes for each current cluster member the member's

* nodeID,
* IP address(es),
* **sig** RSA public key, and
* **comms** RSA public key

<img src="img/cluster-with-clients.jpg" alt="cluster-with-clients" style="float:left" title="cluster with clients">

The new cluster member can then use this information to communicate with
other members.  Cluster members need no further assistance from the
xlReg server.

Cluster members will communicate with one another and clients
using protocols agreed-upon among themselves, but the xlReg registry
has no knowledge of such protocols.

**xlreg_r** is currently in development.  This is not
necessarily a description of running code; it is where we are going.

xlReg is an [XLattice](http://jddixon.github.io/xlattice_go/) project.  More
detailed (but somewhat dated) conceptual information on XLattice
is available at the [2003-2006 Java XLattice website](http://www.xlattice.org).

xlReg servers and clients communicate using the
[Gooble Protocol Buffers](http://code.google.com/p/protobuf/)-based
[xlReg protocol](http://jddixon.github.io/xlReg_go/xlReg_protocol.html).
An xlReg server has been in test for several months.

## Public Development Server

There is currently an xlReg server running on xlreg.xlattice.org:56789,
with the public keys shown in the registry credentials below.

	regCred {
	    Name: xlReg
	    ID: 9cf517be9bcaaeb794a7530dd34ae873651c41b4
	    CommsPubKey: ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDfxYMpgUX1/QH5nLN5I8gW9xewU4NFOGEOlsiFKU2R/NbmiyVOl2UyfuSFmZLauT3hJh9PsVyrHkfyiSJrd9k4Wjy3UKi3hZY7AIuHBLdbIrdOQiDTkkrfIv80ogjpMFsSivY4NTYrsPtXihi+E2iZlabv3m3PqKycjXDU/PZEAw+W6fsg1GCJTbGWtDoNQk6hbMS3UhOxL1G/WWB1V9lYXflLsv+Oym5/y1mUR4B7N2Uey1J5XQuIfXpJaM/+qNy2X1fB6575iJzvES791OszI3cvBFNReySbR/SUJqcFIZAbtj4swnoAFkyQ0zlN1Ok6Iacp5bTq8upYi3TyZcPr
	
	    SigPubKey: ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCzouB3y/p7VdnJ66p4NLZa5Z4IyPtMryEp3URPlUC25LuzT2b/utrMvTX4fAXnuPF/v/qhQKm0LOOW+YnEk1vwN0HsEvD/9D8qYkBBIv636w4k2k+O4Lt1rQ32t22AbEHOjIZtVdfoZm9/ypd8ogchkr7yH/Na6FE0UySh0dJDf9HlYcfjYy1IkkAgGlWmCX61LJ4Wgw00QkkuztlVUnRjEW9MIohgVcFx/+gF/shtmy0rCGYpLszdMlGGaGCzXO1PK3BVLaZPKfcafUzfksif+vWqEQ0KnmjtV5it0wEa89IebAEW7cS1rvyRH2Y8/gie5CkgwHve/hgThY3KSUih
	
	    EndPoints {
	         TcpEndPoint: 54.186.197.123:56789
	    }
	    Version: 1.8.2
	}

The IP address in the reg credentials above is of course that of xlreg.xlattice.org.

## Server Implementation

The xlReg server and its supporting libraries are written in
[the Go programming language](http://golang.org), a high-performance
systems programming language incorporating certain features of
[Tony Hoare](http://en.wikipedia.org/wiki/Tony_Hoare)'s
revolutionary **CSP**,
[Communicating Sequential Processes](http://www.usingcsp.com).

Google's Go language is a stable product.  It has been available for 
several years and the compiler is widely acknowledged to be very fast
and to generate fast, compact code.  The Go language itself --
the compiler and its libraries -- is free and open source.

## Server Source Code

Software developers can currently obtain the xlReg server source code at
[xlReg_go's Github project page](https://github.com/jddixon/xlReg_go/)
so that if you are impatient to begin using xlReg you can build and operate
your own server.

## Client Source Code

This is best obtained through
[this client's Github project page](https://github.com/jddixon/xlreg_r/).

## Project Status

The xlReg server is currently a good beta: it is reasonably reliable and
there are no known serious bugs.

**This client is itself pre-alpha:** some minimal code exists, but nothing
beyond reading the registry credentials (`regCred.dat`) and going through
the initial hello/reply session with the server, xlReg.

## On-line Documentation
More information on the **xlreg_r** project can be found 
[here](https://jddixon.github.io/xlreg_r)

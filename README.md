# xlreg_r

A Ruby client for the xlReg cluster registry.

[xlReg](http://jddixon.github.com/xlattice_go/xlReg.html)
is a service which provides unique nodeIDs and allows you to register
and join clusters.

An xlReg cluster is a number of machines
which will cooperate as a set of intercommunicating servers.  Each
such server has two RSA keys.  One, the *sig* key, is used for creating digital signatures.
The other, the *comms* key, is used for encrypting communications.  Each server also has at
least one IP address used for intra-cluster communications.  In some
clusters each will also have a second IP address used for communications
with cluster clients.

The xlReg server itself, its clients, and so the cluster members all are
or behave like
[XLattice nodes](http://jddixon.github.io/xlattice_go/node.html).
That is, they are self-contained fault-tolerant entities with some
persistent store.  These nodes may be located anywhere on the global
Internet, or on private networks with access to the network in which
the xlReg server resides.`

An xlReg client first contacts the server to provide configuration
information including its RSA public keys.  (The client does _not_ register
its secret RSA private keys.)  The configuration information is signed
with the applicant's *sig" key.  The server then uses the client's
public key, provided as part of the configuration information, to verify
the digital signature.  This proves that the configuration information
is intact and that the applicant has the private key corresponding to the
public key.  In other words, the server has in a certain sense confirmed
the applicant's identity.  Having done this, the xlReg server issues the client
with a unique node ID, a 32-byte value, completing client registration.

Once an xlReg client has identified itself to the registry it
can register new clusters or join existing clusters.

After a machine joins a cluster the server
provides it with contact information for the other members of the
cluster (ID, IP address(es), and **sig** and **comms** public keys).  The
cluster members can then use this information to communicate with
one another.  They need no further assistance from the xlReg server.

Cluster members will communicate with one another and clients
using protocols agreed-upon among themselves, but xlReg has no knowledge
of these.

**xlreg_r** is currently in development.

xlReg is an [XLattice](http://jddixon.github.io/xlattice_go/) project.
More detailed (but somewhat dated) conceptual information on XLattice
is available at the [XLattice website](http://www.xlattice.org).

xlReg servers and clients communicate using the
[Gooble Protocol Buffers](http://code.google.com/p/protobuf/)-based
[xlReg protocol](http://jddixon.github.io/xlattice_go/xlReg_protocol.html).
An xlReg server has been in test for several months and will shortly be
available for public use.

## On-line Documentation

More information on the **xlreg_r** project can be found [here](https://jddixon.github.io/xlreg_r)

Received: from eggs.gnu.org ([2001:4830:134:3::10]:53507)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eYvHJ-0007Wb-44
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 09:53:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eYvHF-0002ru-TV
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 09:53:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38928)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1eYvHF-0002rX-MT
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 09:53:21 -0500
Date: Tue, 9 Jan 2018 14:52:49 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180109145248.GJ31400@stefanha-x1.localdomain>
References: <20171219084557.9801-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EVh9lyqKgK19OcEf"
Content-Disposition: inline
In-Reply-To: <20171219084557.9801-1-peterx@redhat.com>
Subject: Re: [Qemu-devel] [RFC v6 00/27] QMP: out-of-band (OOB) execution
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <shajnocz@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>, marcandre.lureau@redhat.com, "Dr . David Alan Gilbert" <dgilbert@redhat.com>


--EVh9lyqKgK19OcEf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 19, 2017 at 04:45:30PM +0800, Peter Xu wrote:
> This v6 kept most of the high level design untouched, however there
> are quite a few of changes that try to make the series more robust and
> safe.  My sincere thank to the reviewers (especially Stefan!) on all
> review comments to previous one.  Let's see how this version goes.
>=20
> v6:

I've finished my review of this revision and posted comments.

Stefan

--EVh9lyqKgK19OcEf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaVNdAAAoJEJykq7OBq3PIwfkH/R5xwhO5GFgrt37s+H3p8YrE
afBnEt8f/VfXnrwG6Umn7BC8a/Aih7XdSnr44GP1r2bAeLUEkyhjE1tQTC5wOv4M
RzsUwRGUWmG+2OaDUri4MIrwSTbnpfntOK+F5WBaga8XMyhe+ARTIbROyshciJ+g
zKY4x9HKC+bmXsTFU2QqH6Z4KqbzQyaZLkYewvAiFG+bg3NLGRaat8SIfa5Wtgqf
TtZTz2CxXeAWMy7Xlss3fiB/7gwSCwy8SZGVbM8c86zgQXM9Z7Pd3TroF06LsqSR
kUL5LRxUIZ2MMXqBDL2xZf3xYp+H7rT0YO9TpYZJg9f/ak/zrNn1envxmfyxMmA=
=C1cL
-----END PGP SIGNATURE-----

--EVh9lyqKgK19OcEf--

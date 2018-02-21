Received: from eggs.gnu.org ([2001:4830:134:3::10]:50256)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eoYSF-0007R6-In
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 12:45:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eoYSC-0000A0-Cn
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 12:45:19 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42122 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1eoYSC-00009l-4O
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 12:45:16 -0500
Date: Wed, 21 Feb 2018 17:45:07 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180221174507.GL21436@stefanha-x1.localdomain>
References: <20180124053957.29145-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sMZCuqyhuhd4ycTi"
Content-Disposition: inline
In-Reply-To: <20180124053957.29145-1-peterx@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v7 00/23] QMP: out-of-band (OOB) execution
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


--sMZCuqyhuhd4ycTi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 24, 2018 at 01:39:34PM +0800, Peter Xu wrote:
> This version should have addressed all comments in previous one, also
> fixed another race condition after I addressed all the comments (a new
> race condition introduced by addressing the comments...).  For some
> more details of the race condition, please see the last entry of
> change log, and please refer to patch 9 for the code change.
>=20
> I removed RFC tag from this version.  Please review.  Thanks.

I have posted comments on a few patches.

Stefan

--sMZCuqyhuhd4ycTi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJajbAjAAoJEJykq7OBq3PIajUH/RsN5bK/LFLHxZroKtwH15vE
9Nor9ue3c6vWEcNb7YSsPGUWfUitfaVSjCZTxaQIDIG7ZUS4fJSuJ+D4Naje5XXq
4ZuVqjxppnVRacPRIKd+aRQiq0jeFE83HiONYiwuUydSg5bNCoUhScZ4fzQdaPrf
n7k6bszdJz9In2ohACm/Iqe9SiC8ZWYDYCe6SZpPOPLyC0qvWa26MkJTwbBtzwke
BxHpDA1VwXn/VEctp8dLKrIthCWwQ/zosHmDXx12+OSGTUnyyTJhM+PkDUyN3VMY
TngRNWa4YpST6iK93Acf9iZkrvlaS6S0SPa9117MURrB0jN2QMGHXckkzSwruao=
=vI3p
-----END PGP SIGNATURE-----

--sMZCuqyhuhd4ycTi--

Received: from eggs.gnu.org ([2001:4830:134:3::10]:47030)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dUX5m-0006LE-PC
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 07:43:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dUX5m-000801-3z
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 07:43:06 -0400
References: <20170707182151.29872-1-eblake@redhat.com>
	<20170710101604.GA19707@lemon.lan>
	<94f33acf-57b4-62b7-7121-4e1e27048224@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5ce2324f-f634-8b00-132e-b36e5f6bce5b@redhat.com>
Date: Mon, 10 Jul 2017 13:42:49 +0200
MIME-Version: 1.0
In-Reply-To: <94f33acf-57b4-62b7-7121-4e1e27048224@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="LBjlCqMPmAhCGqGNOc8tmE3Xjj3Dv7J6L"
Subject: Re: [Qemu-devel] [PATCH] MAINTAINERS: Promote NBD to supported,
 with new maintainer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--LBjlCqMPmAhCGqGNOc8tmE3Xjj3Dv7J6L
From: Paolo Bonzini <pbonzini@redhat.com>
To: Eric Blake <eblake@redhat.com>, Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
Message-ID: <5ce2324f-f634-8b00-132e-b36e5f6bce5b@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] MAINTAINERS: Promote NBD to supported, with
 new maintainer
References: <20170707182151.29872-1-eblake@redhat.com>
 <20170710101604.GA19707@lemon.lan>
 <94f33acf-57b4-62b7-7121-4e1e27048224@redhat.com>
In-Reply-To: <94f33acf-57b4-62b7-7121-4e1e27048224@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/07/2017 13:42, Eric Blake wrote:
>>> +T: git git://repo.or.cz/qemu/ericb.git nbd
>> Out of curiosity: Paolo is still in "M:", but his "T:" is gone.  Inten=
ded?
> Hmm, I didn't realize you could list two T: entries, but a quick check
> shows that is the case for several co-maintained areas.  Paolo, any
> preference?

My "T:" has been obsolete since I've started doing the "gather random
patches" work, so it's okay to remove it.

Paolo


--LBjlCqMPmAhCGqGNOc8tmE3Xjj3Dv7J6L
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEE8TM4V0tmI4mGbHaCv/vSX3jHroMFAlljaD0ACgkQv/vSX3jH
roOC4wgAp7pMKU5KFOkdDofALKHv4oxo04i/ZJwLbwoZgQdARUFNYPf+9Ar7JHLg
KPkuUxxxR8c1PDMWx80GIeHdaVzDeW5vCVOD9G2oDOWSzkiGGvooAHic5buwVvQY
jnVrSWRQU4JCbdc5B6kTLd3Ru6HARVH4ouMUrvkKWqiEOkkSEQHdVrkhxwGPbBGa
ohfsWjLSpd4UmSc2TcOKd1QJX6EPyLnN1ZmLiIlhyH5b2JfW5GtleHdJVgVYhy/p
HDJW8U/LHwxLXY764LUTonMpuZl2lzcaVZ4yn2v63UAARIPVmksxt6U7dJVrejaa
gacrP8cCSRhhY1qw0zKPbWxqWW8Zdg==
=IDQs
-----END PGP SIGNATURE-----

--LBjlCqMPmAhCGqGNOc8tmE3Xjj3Dv7J6L--

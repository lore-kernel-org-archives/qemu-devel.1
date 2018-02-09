Received: from eggs.gnu.org ([2001:4830:134:3::10]:42091)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ekDe6-000580-FB
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 13:43:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ekDe5-0000T0-OL
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 13:43:38 -0500
References: <20180208192328.16550-1-kwolf@redhat.com>
	<20180208192328.16550-11-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <214df803-bcee-c93e-239e-f7c9fb37f89d@redhat.com>
Date: Fri, 9 Feb 2018 19:43:14 +0100
MIME-Version: 1.0
In-Reply-To: <20180208192328.16550-11-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="CTRuQd3XSqzatcb9l0tRM8BKlVdL2zm2v"
Subject: Re: [Qemu-devel] [PATCH 10/27] qcow2: Use visitor for options in
 qcow2_create()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: pkrempa@redhat.com, eblake@redhat.com, jcody@redhat.com, jdurgin@redhat.com, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--CTRuQd3XSqzatcb9l0tRM8BKlVdL2zm2v
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: pkrempa@redhat.com, eblake@redhat.com, jcody@redhat.com,
 jdurgin@redhat.com, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com,
 qemu-devel@nongnu.org
Message-ID: <214df803-bcee-c93e-239e-f7c9fb37f89d@redhat.com>
Subject: Re: [PATCH 10/27] qcow2: Use visitor for options in qcow2_create()
References: <20180208192328.16550-1-kwolf@redhat.com>
 <20180208192328.16550-11-kwolf@redhat.com>
In-Reply-To: <20180208192328.16550-11-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-02-08 20:23, Kevin Wolf wrote:
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/qcow2.c              | 219 ++++++++++++++++---------------------=
--------
>  tests/qemu-iotests/049.out |   8 +-
>  tests/qemu-iotests/112.out |   4 +-
>  3 files changed, 84 insertions(+), 147 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--CTRuQd3XSqzatcb9l0tRM8BKlVdL2zm2v
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlp968ISHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AyTUH+gIa6ftb/sgwFaq18VSnkB3ZVnuwvxj0
jThFX13sCqn20tXWe4oEhwOC5CPGuI4Y5FzmTCPxGfaPB7SNQm0hrNvdu9sSBn0x
Y+r4jPt99UtLsDL8myHC7zIJvT1Gi33ZZsTFsizBaR//RPGQBQwoJ8DUXZIsHupN
Gh3VKj42pl0JLYHuuRD6woyj0FmdxaTURTZs/jm/fkZdBds5+01XyU3qOTz7RhN3
Kh7O2mFQyJ46zrf1HzX2W/uMQTO+7jJfZWXoJa71N9sWR9JCIK/Egj/a2meF66SY
62y7Tu5ml2dmuURJtntYNl4eZ9ossSPpmPtg9S84rlFYOxuL0vgSEtY=
=4GKM
-----END PGP SIGNATURE-----

--CTRuQd3XSqzatcb9l0tRM8BKlVdL2zm2v--

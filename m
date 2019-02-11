Received: from eggs.gnu.org ([209.51.188.92]:39443)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gtOCs-0001UK-DQ
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 21:53:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gtOCr-0002sM-FS
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 21:53:58 -0500
Date: Mon, 11 Feb 2019 14:04:57 +0800
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20190211060457.GK18083@stefanha-x1.localdomain>
References: <20190207102445.71998-1-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cEobB2knsyc5ebfU"
Content-Disposition: inline
In-Reply-To: <20190207102445.71998-1-vsementsov@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH v3 00/17] block: local qiov helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, dgilbert@redhat.com, quintela@redhat.com, jsnow@redhat.com, den@openvz.org, fam@euphon.net, mreitz@redhat.com, kwolf@redhat.com, jcody@redhat.com


--cEobB2knsyc5ebfU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 07, 2019 at 01:24:28PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> v3:

Will you send a v4 based on Eric's comments or do you want to keep the
series as it is?

Stefan

--cEobB2knsyc5ebfU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcYRCJAAoJEJykq7OBq3PIRYkIAMlO8Kko1ArvnSNQsu2gaEC0
BshbDgnCyqdY9XddLFKp5PXKcUIRE+Et6iGEjNhOqbxo71BpjaJ/QsnWjLYY3QFJ
J/RhBSZm1XKVPGYWtuGUpyCBi08pX6OP7MgVH4YMTxeH7arwtiFT52QuGhnpKfTK
olYIlfdkIaXkn5f+vFQMDmAllbjJunfTwe/p6BuBPxqBkflF5gqK5uvZzobs70u1
/OPWnoYF7ZpZtlhafP/mudU+wiFbwhmZtM7S1Fj+YvvBERU2AphUqNmgpiaoNPPh
6VaBi1DBqRAPxccPPD4JqW5D16EVaOa/OdYWlkwY4gwTdqfZq1rdJgTPAU/vUY0=
=vxI4
-----END PGP SIGNATURE-----

--cEobB2knsyc5ebfU--

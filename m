Received: from eggs.gnu.org ([2001:4830:134:3::10]:54647)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pkrempa@redhat.com>) id 1gUWN7-0003sE-B9
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 07:33:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pkrempa@redhat.com>) id 1gUWN4-0000z9-4m
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 07:33:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48440)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pkrempa@redhat.com>) id 1gUWN3-0000yN-UR
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 07:33:42 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7BE01315485E
	for <qemu-devel@nongnu.org>; Wed,  5 Dec 2018 12:33:40 +0000 (UTC)
Date: Wed, 5 Dec 2018 13:33:37 +0100
From: Peter Krempa <pkrempa@redhat.com>
Message-ID: <20181205123337.GI799@angien.pipo.sk>
References: <1f7db2e27758f26d4c10f7a8ed1d8232635f6909.1536044449.git.pkrempa@redhat.com>
	<20181004113412.GI21448@angien.pipo.sk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="M0YLxmUXciMpOLPE"
Content-Disposition: inline
In-Reply-To: <20181004113412.GI21448@angien.pipo.sk>
Subject: Re: [Qemu-devel] [PATCH] qapi: Add vim magic modelines for qapi
 definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>


--M0YLxmUXciMpOLPE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 04, 2018 at 13:34:12 +0200, Peter Krempa wrote:
> On Tue, Sep 04, 2018 at 09:03:10 +0200, Peter Krempa wrote:
> > The files have a json suffix but look terrible with json syntax
> > hilighting enabled. Add a magic modeline for vim to switch to python
> > file format for hilighting similarly to the emacs modeline already
> > present.
> >=20
> > Signed-off-by: Peter Krempa <pkrempa@redhat.com>
> > ---
>=20
> Ping?

Ping 2. It looks like no new json files were added meanwhile.

--M0YLxmUXciMpOLPE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEUn7DGLvflazX+2GwHGwCByjY1GoFAlwHxZwACgkQHGwCByjY
1Gprlw/7B/nHEK0LiPHNQv6hjU/+95b8InnLEg2+qv9T3XmP+xYzczSqN9I5iobn
sN7gjGi1WL/mYxLIJ9rlcy17jKgTqLe9xSdIB+/1Uh55PbPde8bmuFUjBuZEnwCY
SCKLkUzrl2PePlkC2h3NT2K+8pkTqF1zelBcjqO1pK91wRXRiPqCAOIp3Y9zOyVb
E4aFqE34kTqWt5/uBgEf8mBAwYW26GX2k9o0OTKJ7aZxInCYJg8cybO3Aylu9K+B
msXnxlg+lxa+dfdP/QBatCs4CH0vXwLhRgTKpbyTpHF1Qqzn2znFAdvGxMAMHGYn
GENEQc7DXYZBhJFo1pg9LNAuLM1lmVjjZWqQnylbI7ryO5/hLWr0y5i3sTB0fnr7
fx9oZyqHkoUHJgxAwjFADSf0SldKKftpkToGj3e2r5Aew5kaHOifEi1A0D5h1eC4
PXyNE2W+rVKTgq5Dn4AFRzxwyZmZEm9UV0cdqo2LJ02vXXrABmTwq1RU5PO0ijwp
Yx1kj4GNQXZpdnwl6S9BpZh+m7fQGLz2AnUpq47p31djyFDcYGmd2h4wbhtyrW0u
NdiV9tS7/89+E34UAqvpqh2+bvttPfe5cn46Z7VbJsxuWRdU/zn08qEF0EJlNDSe
9ee7eVrZlxPSyMtQwdWapqNDzCaJXpHLesGR01A/W78CWGjaZqg=
=5M1u
-----END PGP SIGNATURE-----

--M0YLxmUXciMpOLPE--

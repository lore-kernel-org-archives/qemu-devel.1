Received: from eggs.gnu.org ([2001:4830:134:3::10]:50281)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cT9ye-00014x-1s
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 11:17:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cT9yd-0003Zd-Bs
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 11:17:48 -0500
References: <20170113205237.30386-1-mreitz@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <16349b64-c042-5180-60ca-a119a062697e@redhat.com>
Date: Mon, 16 Jan 2017 17:17:36 +0100
MIME-Version: 1.0
In-Reply-To: <20170113205237.30386-1-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="XSM19CJElK3DdUhIg2Nu5FcOIGC3W1307"
Subject: Re: [Qemu-devel] [PATCH v6 0/9] block: Drop BDS.filename
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XSM19CJElK3DdUhIg2Nu5FcOIGC3W1307
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Eric Blake <eblake@redhat.com>
Message-ID: <16349b64-c042-5180-60ca-a119a062697e@redhat.com>
Subject: Re: [PATCH v6 0/9] block: Drop BDS.filename
References: <20170113205237.30386-1-mreitz@redhat.com>
In-Reply-To: <20170113205237.30386-1-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Sorry, for some reason the mail server did not like patch 6 originally.
That's why it cut off there on Friday and I didn't notice until today.
For some reason, modifying the time zone there from -0700 to +0200 fixed
it (???)...

Max


--XSM19CJElK3DdUhIg2Nu5FcOIGC3W1307
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlh88iASHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AhVoH/0AH7URTklgGMMiedSHz0LnhFJ1Fyl3T
OTMmpH/XRcGrwSar+e9nFAjXZwMI4LCAm/fhzP+p7QMAQFG1KTnJZhUPUHMfVF3r
GdlpSefISujdFcz9D/WxNUeCYFTmH9dl+eZvv7lHo90uPIq1t4EUO6LZ9o08/9ii
o/7CUtTA+cCoPhnLjBcUR2TIPmk3iDIfadAMx3b7uHLW0z/tMy7QVn9J3C8gD0DJ
N+qoXhZ6EAZCBX9pxeFAuk9aNDyhS5fxRf0PuopcMFCz4T/eqaLxNgdVofCj0ZeP
FtDtPczMHX0dfK6OrTlLKuo9BpTo9XN96HfIftQeJG9vQyAZvHf/r8c=
=itrb
-----END PGP SIGNATURE-----

--XSM19CJElK3DdUhIg2Nu5FcOIGC3W1307--

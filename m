Received: from eggs.gnu.org ([2001:4830:134:3::10]:45992)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cTEEW-0001b5-Kx
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 15:50:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cTEEV-00046B-Tz
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 15:50:28 -0500
References: <20170111181432.18868-1-mreitz@redhat.com>
	<20170111181432.18868-5-mreitz@redhat.com>
	<ee5ed185-f4d7-be4e-868d-07091fa6fad8@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <d7ee0118-dd56-43a3-2c75-681ad64acd83@redhat.com>
Date: Mon, 16 Jan 2017 21:50:19 +0100
MIME-Version: 1.0
In-Reply-To: <ee5ed185-f4d7-be4e-868d-07091fa6fad8@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="49q6IXJ8ofoV3uR5Nfkt35S27wcM52jIv"
Subject: Re: [Qemu-devel] [PATCH v4 04/25] block: Respect backing bs in
 bdrv_refresh_filename
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Alberto Garcia <berto@igalia.com>, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--49q6IXJ8ofoV3uR5Nfkt35S27wcM52jIv
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Alberto Garcia <berto@igalia.com>,
 Kevin Wolf <kwolf@redhat.com>
Message-ID: <d7ee0118-dd56-43a3-2c75-681ad64acd83@redhat.com>
Subject: Re: [PATCH v4 04/25] block: Respect backing bs in
 bdrv_refresh_filename
References: <20170111181432.18868-1-mreitz@redhat.com>
 <20170111181432.18868-5-mreitz@redhat.com>
 <ee5ed185-f4d7-be4e-868d-07091fa6fad8@redhat.com>
In-Reply-To: <ee5ed185-f4d7-be4e-868d-07091fa6fad8@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 16.01.2017 21:43, Eric Blake wrote:
> On 01/11/2017 12:14 PM, Max Reitz wrote:
>=20
> The mail archives show this series stopping at 4/25; what happened to 5=
-25?
> https://lists.gnu.org/archive/html/qemu-devel/2017-01/threads.html#0191=
2

Oops. Somehow, the Red Hat mail server really hates me recently... I'll
try to get them out.

Max


--49q6IXJ8ofoV3uR5Nfkt35S27wcM52jIv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlh9MgsSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9ASzcH/1M/06e8AZsOC6PZrc5o/95yKWGwZVhI
h5Bo/S753V+1CkO4oMm1knhLUjTA4cuII69GQDC97mCuzCsjx2BdcwRvPIlrtia9
PtvYnJJgXWlrcf7M2HwwjyyAAiSwiOE2hDtzzo+nm1CO119NLRMfyZSgY7DoaDQ0
DsUYX2Dd3jbqKEmbtKOHPOGwYdWsYMEb7DgTlBq7FOT1HiqiaAm800gQB/5Wzx6C
ovv0Lf/yRzUPnvwRjVLK050wtv0e6PtphRSFa5ZQXthb46fLoN61Yxgf3tigDEFc
Rbxg49C7dc0A/lA8Tel/Hp0emXgLOYjOjWLXlkIEpKvXQ7mVQTvxwT8=
=vMMX
-----END PGP SIGNATURE-----

--49q6IXJ8ofoV3uR5Nfkt35S27wcM52jIv--

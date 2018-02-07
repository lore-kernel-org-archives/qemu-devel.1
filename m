Received: from eggs.gnu.org ([2001:4830:134:3::10]:58820)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ejY3y-0003dJ-Pj
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 17:19:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ejY3y-0006i6-26
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 17:19:34 -0500
References: <20180119205847.7141-1-jsnow@redhat.com>
	<20180119205847.7141-8-jsnow@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <8febe417-e13d-a18d-0ede-84621fb9e4f5@redhat.com>
Date: Wed, 7 Feb 2018 23:19:06 +0100
MIME-Version: 1.0
In-Reply-To: <20180119205847.7141-8-jsnow@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="i0xJ8abJ3Do6Qro3yT0tMyMDbxZINrLUr"
Subject: Re: [Qemu-devel] [PATCH v2 07/13] block/backup: use block_job_relax
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org
Cc: kwolf@redhat.com, jcody@redhat.com, qemu-devel@nongnu.org, stefanha@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--i0xJ8abJ3Do6Qro3yT0tMyMDbxZINrLUr
From: Max Reitz <mreitz@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org
Cc: kwolf@redhat.com, jcody@redhat.com, qemu-devel@nongnu.org,
 stefanha@redhat.com
Message-ID: <8febe417-e13d-a18d-0ede-84621fb9e4f5@redhat.com>
Subject: Re: [PATCH v2 07/13] block/backup: use block_job_relax
References: <20180119205847.7141-1-jsnow@redhat.com>
 <20180119205847.7141-8-jsnow@redhat.com>
In-Reply-To: <20180119205847.7141-8-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-01-19 21:58, John Snow wrote:
> See two commits back for justification.

When will git-log support hyperlinks so you can write "HEAD^^" here? ^^

Max


--i0xJ8abJ3Do6Qro3yT0tMyMDbxZINrLUr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlp7e1sSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9A5ZEH/jNQlSdX+6Iw2aNLWnXlUQ5CDpKhO2zK
fu3MPwRk6eL3BPV3yc4IVwyo/ONzSC6+1mU7Gr6nVPUVAAqT7CCW9S+UxhGXPmou
8ZvT+uZxXehxsh8AZfM1q5Qqm/VbHdVGZ6CcHVIJ9NJk6nL6ZmeQpACwpGb6HOeB
OYZls99oOBMhYEUWy+/xqoXH/MnHIl3GGJ67IqELLiHLXXMIYQTKPm1H/Xs/RVMo
N9JIow3Av3Ot+/dP3RV6by05jJt5OIuJuRopmDPM+8HwDWk604FvFwYO2B3CXDpF
M1O2FgFN1tzv1pEaf4hu0QV8Mr9xh/yrHHuI8V0Jibl1KP2KxbKtrc4=
=60b/
-----END PGP SIGNATURE-----

--i0xJ8abJ3Do6Qro3yT0tMyMDbxZINrLUr--

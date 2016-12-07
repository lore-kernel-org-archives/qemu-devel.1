Received: from eggs.gnu.org ([2001:4830:134:3::10]:42787)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cEcKX-00075Y-He
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 08:32:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cEcKT-0004Vg-Tp
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 08:32:17 -0500
Date: Wed, 7 Dec 2016 13:30:49 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20161207133049.GA32099@stefanha-x1.localdomain>
References: <1480575357-25056-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<a1593129-ddb9-8e74-5865-b1e8400c991d@redhat.com>
	<8b90a1da-a129-f2cb-4545-355348387925@cn.fujitsu.com>
	<063dfa33-2015-e566-c623-d59578c20fcd@redhat.com>
	<13aed710-c5d1-b1de-5922-52e3e53029f9@cn.fujitsu.com>
	<956d6c43-0904-e094-1adb-bb7c584967d0@vivier.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nFreZHaLTZJo0R7j"
Content-Disposition: inline
In-Reply-To: <956d6c43-0904-e094-1adb-bb7c584967d0@vivier.eu>
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH for-2.8] docs: Fix
 description of the sentence
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>, Laurent Vivier <lvivier@redhat.com>, Eric Blake <eblake@redhat.com>, qemu devel <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>, Michael Tokarev <mjt@tls.msk.ru>, Stefan Weil <sw@weilnetz.de>


--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 07, 2016 at 10:01:49AM +0100, Laurent Vivier wrote:
> Le 07/12/2016 =E0 09:58, Zhang Chen a =E9crit :
> >=20
> >=20
> > On 12/02/2016 03:57 PM, Laurent Vivier wrote:
> >>
> >> On 02/12/2016 03:59, Zhang Chen wrote:
> >>>
> >>> On 12/01/2016 10:57 PM, Eric Blake wrote:
> >>>> On 12/01/2016 12:55 AM, Zhang Chen wrote:
> >>>>> Say it in another way to make it easier to understand.
> >>>>>
> >>>>> Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
> >>>>> Signed-off-by: Eric Blake <eblake@redhat.com>
> >>>> I guess that's because I suggested the replacement text to use, even
> >>>> though I didn't write the patch.
> >>> Yes, In that case, should I change the signed-off-by to acked-by or
> >>> remove it?
> >> You can use "Suggested-by:"
> >>
> >> https://www.kernel.org/doc/Documentation/SubmittingPatches
> >>
> >> Laurent
> >>
> >=20
> > Should I fix it? or can you pick up this directly for 2.8?
>=20
> I don't think it is needed.
> Perhaps Stefan H can take it directly in his staging tree?

Too late for that now.  This should be merged through Jason Wang (net
maintainer) like any other colo-proxy patch.

Stefan

--nFreZHaLTZJo0R7j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYSA8JAAoJEJykq7OBq3PIy5sH/3wXENzI0kcJ0ZiUZeNVtMB3
IExdr5PLpiW1sygrAoUVrYKBPaDHm6iP6WQuMZUCBB3dP+A5PYHpi6+ZMuoHkKbU
D8+vaEXi2OV3pvpgVXHq5n0TCQkkm2oUb/O1AmabB2QadvfdPUM5sMj+71VUXsie
6vWoy8m/gwayMlNhtjY1e3RGowe8PsMrZrjJ1eaGotkdJdpnp0CcEPi1WrUR7lXk
6sKru9BAzP3zAI9nXl4kDsNMdS9UF1ZtouY6ZLoSWAmpmguai3a2ECUaZPwStZYw
VIduslTg0r0maSytYuMzGeWmaQzfdoN3ATAJW/pzYLuSSSx1SR2kLdDJ7Zl88gc=
=Q5qe
-----END PGP SIGNATURE-----

--nFreZHaLTZJo0R7j--

Received: from eggs.gnu.org ([2001:4830:134:3::10]:49757)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <n54@gmx.com>)
	id 1gUi8T-0001zT-11
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 20:07:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <n54@gmx.com>) id 1gUi8P-0002MK-3l
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 20:07:24 -0500
Received: from mout.gmx.net ([212.227.17.20]:52241)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <n54@gmx.com>) id 1gUi8O-0002KF-K9
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 20:07:20 -0500
References: <CAPyFy2CWKEmYoYrDY=pHQVxXjMZnPts5qKVHL94yx0smTjx9bA@mail.gmail.com>
	<9b63140e-1d06-27d0-7686-226b7045931e@gmx.com>
	<CAPyFy2BzUE-OA0PqYQtG2=QFO4n1KWEq-8PrpkxhTxYvYJVcGw@mail.gmail.com>
From: Kamil Rytarowski <n54@gmx.com>
Message-ID: <2537a001-61b7-d44e-6c44-52d07a8aa85e@gmx.com>
Date: Thu, 6 Dec 2018 02:08:13 +0100
MIME-Version: 1.0
In-Reply-To: <CAPyFy2BzUE-OA0PqYQtG2=QFO4n1KWEq-8PrpkxhTxYvYJVcGw@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="LDj76bT4xEqYCXVI1QxAQUtd8o2SbfLk3"
Subject: Re: [Qemu-devel] Hosted CI for FreeBSD - Cirrus CI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ed Maste <emaste@freebsd.org>
Cc: qemu-devel <qemu-devel@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--LDj76bT4xEqYCXVI1QxAQUtd8o2SbfLk3
From: Kamil Rytarowski <n54@gmx.com>
To: Ed Maste <emaste@freebsd.org>
Cc: qemu-devel <qemu-devel@nongnu.org>
Message-ID: <2537a001-61b7-d44e-6c44-52d07a8aa85e@gmx.com>
Subject: Re: [Qemu-devel] Hosted CI for FreeBSD - Cirrus CI
References: <CAPyFy2CWKEmYoYrDY=pHQVxXjMZnPts5qKVHL94yx0smTjx9bA@mail.gmail.com>
 <9b63140e-1d06-27d0-7686-226b7045931e@gmx.com>
 <CAPyFy2BzUE-OA0PqYQtG2=QFO4n1KWEq-8PrpkxhTxYvYJVcGw@mail.gmail.com>
In-Reply-To: <CAPyFy2BzUE-OA0PqYQtG2=QFO4n1KWEq-8PrpkxhTxYvYJVcGw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05.12.2018 22:58, Ed Maste wrote:
> On Wed, 5 Dec 2018 at 15:59, Kamil Rytarowski <n54@gmx.com> wrote:
>>
>> There are already FreeBSD, OpenBSD and NetBSD test scripts in the qemu=

>> project.
>=20
> I see scripts under tests/vm/ for FreeBSD, NetBSD, and OpenBSD, but
> they're for testing BSD guests on QEMU, while I'm interested in
> building and testing QEMU on a FreeBSD host. Is there something else
> that I've missed?
>=20

These tests build qemu in guest and execute tests, so BSDs are tested as
an [emulated] host.


--LDj76bT4xEqYCXVI1QxAQUtd8o2SbfLk3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJABAEBCAAqFiEELaxVpweEzw+lMDwuS7MI6bAudmwFAlwIdn0MHG41NEBnbXgu
Y29tAAoJEEuzCOmwLnZshs4P/ikGh7u4iOX2eussNTdPFFKmJAq9X1m1KKjRf41t
qq0dTFvkFdP5FRDuRQV18lKTX3NIT0nOmaTU4gl+yCzvFJhiE9M+yzH50ReEi6NS
y2gCEXTgG7WE1BCxoSQI60bFVoWNvELfob1cUpVFdnTjBjdo4T71fsHy/8sybe0M
hbv2bSGl4dQmVkJp39g62Fdkd7O23qcVaY/kc51ZILHECLrlcX4loIMStByzTrUH
GdLuwKrGg8ZPpyhusFvVG3kdpiVxmIe1gnvNGyDA7obxpHmBssKUJB36nKuS772j
QoP7ga1erhlBLqMirVDlLapWhEKxCt9666pxJxnzCVXyGw7v/RCfc3rL0mHrGYY0
pY9s9q9wrPdufL6KO0EzCuezPDPSB/ndQBnC1fLFdaNiD5eZuzpB8gFbzsh2BC4B
z1lEn9wvvs2YnY0nCB9A7H5Vu7gds/7ysVrGDsUqfNM06+EJCSfFyGhrEFHSZDCk
rxd0bcaSkeqPKbgJDbGJqmuzM553+waEQOs9LGQFwFn4YrMF9byx9VIG/cQbAMLH
vavhjsxy+vlcs2ciC/ejJzVz8zf7U7303CqF/B2eReJ17hzqq0dNNAtn337InLLq
JBtrbUIjZgVrb6B6FaiOZ28oiRkXw8JCjI8IrcToqF10DMoqvZHEScbZT6WVveX6
m1Fr
=Hqmo
-----END PGP SIGNATURE-----

--LDj76bT4xEqYCXVI1QxAQUtd8o2SbfLk3--

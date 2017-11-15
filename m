Received: from eggs.gnu.org ([2001:4830:134:3::10]:35877)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eF6cQ-0000FM-OD
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 17:57:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eF6cQ-00066q-1A
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 17:57:18 -0500
From: Max Reitz <mreitz@redhat.com>
References: <CAJH6TXiMxUoU2sFEHAoZ8jhDMtg_saEnTHM9f0vJ6Nhqj7099w@mail.gmail.com>
	<c2ecae32-f999-9f1e-46a6-37cdab2a62e3@redhat.com>
	<CAJH6TXhBAaBE9gBSxksWZqNywWmencRaGyeY-oN3jbKdgUettQ@mail.gmail.com>
	<0e6cc220-814a-17fd-4fd7-7b0665d34e81@redhat.com>
	<CAJH6TXh2v-F=yqxQbUUawk_Ctq-sgFefGp1XvMsC=syX_5jEqA@mail.gmail.com>
	<30b54865-2255-d13d-a054-afcf5bbd06b2@redhat.com>
	<20171115202440.GJ19514@redhat.com>
	<7b11bb2b-b93d-e8ff-f396-703c93549d0d@redhat.com>
	<20171115202938.GN2787@redhat.com>
	<CAJH6TXiPuLu62-+o2+PrUGpstrks_5pLotFEe1bAOmsbn20otw@mail.gmail.com>
	<5b6f8758-5e3e-e759-1592-2768eb85b322@redhat.com>
	<CAJH6TXgrOWxP7jFg98_jv-R1nrFKOXBQA6pPxbkzGWTVW=EReA@mail.gmail.com>
	<CAJH6TXg7eCiqH+3Wq=-QEH3xFhJJekTXm+c1F5w7BebiQGni8A@mail.gmail.com>
	<d8b9ba38-f39a-9b79-ac89-64e9ab3e6a33@redhat.com>
	<04518567-9905-c22c-78f8-ea9dcde7e7ac@redhat.com>
Message-ID: <a31265b5-3c4b-d179-a3d3-9003839a22ca@redhat.com>
Date: Wed, 15 Nov 2017 23:57:06 +0100
MIME-Version: 1.0
In-Reply-To: <04518567-9905-c22c-78f8-ea9dcde7e7ac@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="xGKipKDWpevmgjdEvNBP5be5GELHA84cw"
Subject: Re: [Qemu-devel] [Libguestfs]  [qemu-img] support for XVA
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Cc: "Richard W.M. Jones" <rjones@redhat.com>, Qemu-block <qemu-block@nongnu.org>, qemu-devel@nongnu.org, libguestfs <libguestfs@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--xGKipKDWpevmgjdEvNBP5be5GELHA84cw
From: Max Reitz <mreitz@redhat.com>
To: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Cc: "Richard W.M. Jones" <rjones@redhat.com>,
 Qemu-block <qemu-block@nongnu.org>, qemu-devel@nongnu.org,
 libguestfs <libguestfs@redhat.com>
Message-ID: <a31265b5-3c4b-d179-a3d3-9003839a22ca@redhat.com>
Subject: Re: [Libguestfs] [Qemu-devel] [qemu-img] support for XVA
References: <CAJH6TXiMxUoU2sFEHAoZ8jhDMtg_saEnTHM9f0vJ6Nhqj7099w@mail.gmail.com>
 <c2ecae32-f999-9f1e-46a6-37cdab2a62e3@redhat.com>
 <CAJH6TXhBAaBE9gBSxksWZqNywWmencRaGyeY-oN3jbKdgUettQ@mail.gmail.com>
 <0e6cc220-814a-17fd-4fd7-7b0665d34e81@redhat.com>
 <CAJH6TXh2v-F=yqxQbUUawk_Ctq-sgFefGp1XvMsC=syX_5jEqA@mail.gmail.com>
 <30b54865-2255-d13d-a054-afcf5bbd06b2@redhat.com>
 <20171115202440.GJ19514@redhat.com>
 <7b11bb2b-b93d-e8ff-f396-703c93549d0d@redhat.com>
 <20171115202938.GN2787@redhat.com>
 <CAJH6TXiPuLu62-+o2+PrUGpstrks_5pLotFEe1bAOmsbn20otw@mail.gmail.com>
 <5b6f8758-5e3e-e759-1592-2768eb85b322@redhat.com>
 <CAJH6TXgrOWxP7jFg98_jv-R1nrFKOXBQA6pPxbkzGWTVW=EReA@mail.gmail.com>
 <CAJH6TXg7eCiqH+3Wq=-QEH3xFhJJekTXm+c1F5w7BebiQGni8A@mail.gmail.com>
 <d8b9ba38-f39a-9b79-ac89-64e9ab3e6a33@redhat.com>
 <04518567-9905-c22c-78f8-ea9dcde7e7ac@redhat.com>
In-Reply-To: <04518567-9905-c22c-78f8-ea9dcde7e7ac@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-11-15 23:55, Max Reitz wrote:
> On 2017-11-15 23:28, Max Reitz wrote:
>> On 2017-11-15 22:50, Gandalf Corvotempesta wrote:
>>> https://stacklet.com/downloads/XenServer-XVA-Template-Debian-7.8-Ligh=
tweight-x86
>>
>> Hmmm, that gives me a timeout when downloading.  And another image I g=
ot
>> gives me an "argument list too long" -- which I had feared already...
>> It has a size of 3 MB and Linux "only" allows 2...
>=20
> OK, being a bit clever helped a lot.
>=20
> https://xanclic.moe/convert-xva.rb -- does this work?
> (It seems to works on the two example images I found...)

Note that I have no idea how to get the total image size from the
ova.xml (or wherever else), so you may have to call qemu-img resize on
the output to get it to the right size.  (It only creates an image that
covers all of the input data blocks.)

Max


--xGKipKDWpevmgjdEvNBP5be5GELHA84cw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAloMxkISHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9Am7gH/jI7w4MYcc5OzqbK1vIrRyqDTj5Leegg
cIYPiiKdBV4giIIp/CQhNm3iHfrH+aDy3slUtCrbAoLS1+roL39hpDEU9Pv8E/uz
9Z8IMXXKho+jAz3Q2Bc7jk+IqFQv+NJCPLz0sbIia6h1yszUgR33zbzEgl5zG8xd
tszNlQz0oTJcdMcKvNwL26RaOeqWUq8arANxKJW8T6+nXUkyo41b3BnWYqPLXGh8
t9dqcHalmRAx09wJyDCH7yWkDcLZvYLN/STocJ1bUskqS2dyu7j3OpSunU0wYhjO
TnyYdEXomezqauTvigyrmbYYd7hPrOQVi4TKF1PouK1jDvG2XWm6iCQ=
=nyQ0
-----END PGP SIGNATURE-----

--xGKipKDWpevmgjdEvNBP5be5GELHA84cw--

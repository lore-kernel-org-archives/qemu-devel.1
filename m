Received: from eggs.gnu.org ([2001:4830:134:3::10]:47184)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eF3y3-0001qT-8n
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 15:07:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eF3y2-0004xH-Bf
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 15:07:27 -0500
References: <CAJH6TXiMxUoU2sFEHAoZ8jhDMtg_saEnTHM9f0vJ6Nhqj7099w@mail.gmail.com>
	<c2ecae32-f999-9f1e-46a6-37cdab2a62e3@redhat.com>
	<CAJH6TXhBAaBE9gBSxksWZqNywWmencRaGyeY-oN3jbKdgUettQ@mail.gmail.com>
	<0e6cc220-814a-17fd-4fd7-7b0665d34e81@redhat.com>
	<CAJH6TXh2v-F=yqxQbUUawk_Ctq-sgFefGp1XvMsC=syX_5jEqA@mail.gmail.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <30b54865-2255-d13d-a054-afcf5bbd06b2@redhat.com>
Date: Wed, 15 Nov 2017 21:07:12 +0100
MIME-Version: 1.0
In-Reply-To: <CAJH6TXh2v-F=yqxQbUUawk_Ctq-sgFefGp1XvMsC=syX_5jEqA@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="U4rk9ToqUvVULXK8Q9bwuvqOH2Bin2LAo"
Subject: Re: [Qemu-devel] [qemu-img] support for XVA
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Cc: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, libguestfs <libguestfs@redhat.com>, Qemu-block <qemu-block@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--U4rk9ToqUvVULXK8Q9bwuvqOH2Bin2LAo
From: Max Reitz <mreitz@redhat.com>
To: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Cc: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org,
 libguestfs <libguestfs@redhat.com>, Qemu-block <qemu-block@nongnu.org>
Message-ID: <30b54865-2255-d13d-a054-afcf5bbd06b2@redhat.com>
Subject: Re: [Qemu-devel] [qemu-img] support for XVA
References: <CAJH6TXiMxUoU2sFEHAoZ8jhDMtg_saEnTHM9f0vJ6Nhqj7099w@mail.gmail.com>
 <c2ecae32-f999-9f1e-46a6-37cdab2a62e3@redhat.com>
 <CAJH6TXhBAaBE9gBSxksWZqNywWmencRaGyeY-oN3jbKdgUettQ@mail.gmail.com>
 <0e6cc220-814a-17fd-4fd7-7b0665d34e81@redhat.com>
 <CAJH6TXh2v-F=yqxQbUUawk_Ctq-sgFefGp1XvMsC=syX_5jEqA@mail.gmail.com>
In-Reply-To: <CAJH6TXh2v-F=yqxQbUUawk_Ctq-sgFefGp1XvMsC=syX_5jEqA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-11-15 21:06, Gandalf Corvotempesta wrote:
> 2017-11-15 20:59 GMT+01:00 Max Reitz <mreitz@redhat.com>:
>> Well, you can't just add support to qemu-img alone either.  Every imag=
e
>> format supported by qemu-img is one supported by qemu as a whole and
>> thus needs a proper block driver that needs to support random accesses=

>> as well.
>=20
> I was talking about qemu-img convert, just to convert an XVA image to
> something different, in a single pass, without having to extract the
> tar.

I know, but that doesn't work.  qemu-img convert uses the normal
general-purpose block drivers for that.

Max


--U4rk9ToqUvVULXK8Q9bwuvqOH2Bin2LAo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAloMnnASHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AODsH/01t4eLrg2rtTmqJzu0OS+2fXCYBNwLw
ePpEltSPUlwZDRN+zVJ101KByh/vVD8fdxrCxae2O0r8Ph3xNr81Up5CTNFD2Ecw
2ZY71lSFBXalzIZJWiyUxON32AsF/tKPqkThNvXZX2E2aIeLigePs8kRNq/Dzy+f
7Y/kXxvwhrlOkFhwwH3/8ttAyXGBvcsDArplBLtdmFVcMtRmjI7U/iVkYUuNjFje
Nbk8J9Aa6k7qDs1CsN5aDK98fV5sn61ksila0LnUmco0548oLF8HHAGQwGgtcKBr
3xdj0F2rjeLAgj5ON9WI47W+PeeVuGUK4dHlJWt2qyi1x5UVWXMacI0=
=gVA6
-----END PGP SIGNATURE-----

--U4rk9ToqUvVULXK8Q9bwuvqOH2Bin2LAo--

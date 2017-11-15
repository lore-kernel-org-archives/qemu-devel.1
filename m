Received: from eggs.gnu.org ([2001:4830:134:3::10]:57149)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eF5Gf-0000Qq-Gc
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 16:30:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eF5Ge-0005dK-I7
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 16:30:45 -0500
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
From: Max Reitz <mreitz@redhat.com>
Message-ID: <5b6f8758-5e3e-e759-1592-2768eb85b322@redhat.com>
Date: Wed, 15 Nov 2017 22:30:31 +0100
MIME-Version: 1.0
In-Reply-To: <CAJH6TXiPuLu62-+o2+PrUGpstrks_5pLotFEe1bAOmsbn20otw@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Jv2KeSTLN9KScniqnEjNnRI1dhW8gt0Xj"
Subject: Re: [Qemu-devel] [Libguestfs]  [qemu-img] support for XVA
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>, "Richard W.M. Jones" <rjones@redhat.com>
Cc: Qemu-block <qemu-block@nongnu.org>, qemu-devel@nongnu.org, libguestfs <libguestfs@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Jv2KeSTLN9KScniqnEjNnRI1dhW8gt0Xj
From: Max Reitz <mreitz@redhat.com>
To: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>,
 "Richard W.M. Jones" <rjones@redhat.com>
Cc: Qemu-block <qemu-block@nongnu.org>, qemu-devel@nongnu.org,
 libguestfs <libguestfs@redhat.com>
Message-ID: <5b6f8758-5e3e-e759-1592-2768eb85b322@redhat.com>
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
In-Reply-To: <CAJH6TXiPuLu62-+o2+PrUGpstrks_5pLotFEe1bAOmsbn20otw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-11-15 21:41, Gandalf Corvotempesta wrote:
> 2017-11-15 21:29 GMT+01:00 Richard W.M. Jones <rjones@redhat.com>:
>> Gandalf, is there an XVA file publically available (pref. not
>> too big) that we can look at?
>=20
> I can try to provide one, but it's simple:
>=20
> # tar tvf 20160630_124823_aa72_.xva.gz | head -n 50
> ---------- 0/0           42353 1970-01-01 01:00 ova.xml
> ---------- 0/0         1048576 1970-01-01 01:00 Ref:175/00000000
> ---------- 0/0              40 1970-01-01 01:00 Ref:175/00000000.checks=
um
> ---------- 0/0         1048576 1970-01-01 01:00 Ref:175/00000001
> ---------- 0/0              40 1970-01-01 01:00 Ref:175/00000001.checks=
um
> ---------- 0/0         1048576 1970-01-01 01:00 Ref:175/00000003
> ---------- 0/0              40 1970-01-01 01:00 Ref:175/00000003.checks=
um
> ---------- 0/0         1048576 1970-01-01 01:00 Ref:175/00000004
> ---------- 0/0              40 1970-01-01 01:00 Ref:175/00000004.checks=
um
> ---------- 0/0         1048576 1970-01-01 01:00 Ref:175/00000005
> ---------- 0/0              40 1970-01-01 01:00 Ref:175/00000005.checks=
um
> ---------- 0/0         1048576 1970-01-01 01:00 Ref:175/00000006
> ---------- 0/0              40 1970-01-01 01:00 Ref:175/00000006.checks=
um
> ---------- 0/0         1048576 1970-01-01 01:00 Ref:175/00000007
> ---------- 0/0              40 1970-01-01 01:00 Ref:175/00000007.checks=
um
> ---------- 0/0         1048576 1970-01-01 01:00 Ref:175/00000009
> ---------- 0/0              40 1970-01-01 01:00 Ref:175/00000009.checks=
um
> ---------- 0/0         1048576 1970-01-01 01:00 Ref:175/00000010
> ---------- 0/0              40 1970-01-01 01:00 Ref:175/00000010.checks=
um
>=20
>=20
> You can ignore the ova.xml and just use the "Ref:175" directory.
> Inside the XVA you'll fine one "Ref" directory for each virtual disk
> (ref number is different for each disk)
> Inside each Ref directory, you'll get tons of 1MB file, corrisponding
> to the RAW image.
> You have to merge these files in a single raw file with just an
> exception: numbers are not sequential.
> as you can see above, we have: 00000000, 00000001, 00000003
>=20
> The 00000002 is missing, because it's totally blank. XenServer doesn't
> export any empty block, thus it will skip the corrisponding 1MB file.
> When building the raw image, you have to replace empty blocks with 1MB
> full of zeros.
>=20
> This is (in addition to the tar extract) the most time-consuming part.
> Currently I'm rebuilding a 250GB image, with tons of files to be
> merge.
> If qemu-img can be patched to automatically convert this kind of
> format, I can save about 3 hours (30 minutes for extracting the
> tarball, and about 2 hours to merge 250-300GB image)

Hmmm...  OK, so as Rich said, you can use the raw driver with an offset
and a size.  And you can use the null-co driver to emulate holes.  And
qemu-img convert supports concatenation.

Taking all of that together, it should be possible to create an input
"file" per 1 MB block and concatenate all of those with qemu-img
convert.  The only issue is that it'll get you a *really* long command li=
ne.

(And you'll still have to gunzip the archive before, of course.)

I'll try to write a script, but of course it's hart without an example...=


Max


--Jv2KeSTLN9KScniqnEjNnRI1dhW8gt0Xj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAloMsfgSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9ATU8IALeKidAZlfUo7i/Iym/dn1jb6THCzMs7
gRDC9vzRnnEx4hI79o0DYS1xghcK9OYhLHF96i8fYs93fkl6vcRfn8EBTdPF2rWY
lqmTpmMKGunZB4d18AeFQQau2RvQgDEJ9yfCDYjM6vWXUKgJ+F/hNLH3T52cuTf+
1PQvkq8JQfPqv3bcR9wNqvzcPg1pc1IjL82FHwh4xljw9u7mHDwK/ypxKfzvXZnB
1PH7TcIaDv2p1bkqf9h96BOuZ5sWRMt9M5gd4KUDgV1jhv6pUZAyOamkOV3Jp0Pv
zPTZQWIGMVNUO9oEhXY+g3wc9vzlMAEddXxMwcdRUDt2xBmI8vM/oPY=
=UTJs
-----END PGP SIGNATURE-----

--Jv2KeSTLN9KScniqnEjNnRI1dhW8gt0Xj--

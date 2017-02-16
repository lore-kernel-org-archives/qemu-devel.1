Received: from eggs.gnu.org ([2001:4830:134:3::10]:40499)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ceO8u-0000E2-Cn
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 10:38:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ceO8r-0001c0-B8
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 10:38:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38364)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ceO8r-0001az-2t
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 10:38:45 -0500
References: <cover.1487139038.git.ben@skyportsystems.com>
	<9dffe31a245cf6a717eef8227fe80ca666b168b5.1487139038.git.ben@skyportsystems.com>
	<20170215115723.77e4d9d7@nial.brq.redhat.com>
	<1f4a6eb2-0838-2218-88e3-4f65498a41d6@redhat.com>
	<20170215162225.74d48058@nial.brq.redhat.com>
	<20170215172515-mutt-send-email-mst@kernel.org>
	<20170215165602.72e96c28@nial.brq.redhat.com>
	<20170215183736-mutt-send-email-mst@kernel.org>
	<20170215184309.521aa90f@nial.brq.redhat.com>
	<20170215194647-mutt-send-email-mst@kernel.org>
	<20170215192436.2695b9f6@nial.brq.redhat.com>
	<670EAA2E-4A15-475E-99B2-8F3B80A33B7F@skyportsystems.com>
	<D02204A1-30A7-40E0-9ED0-9C734AD8F0B1@skyportsystems.com>
	<20170216121045.6ae68c19@nial.brq.redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <05717ea0-dd3b-02bc-7e28-ea25d3f74545@redhat.com>
Date: Thu, 16 Feb 2017 09:38:41 -0600
MIME-Version: 1.0
In-Reply-To: <20170216121045.6ae68c19@nial.brq.redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="O0Owis85laWXf0UWjHETNONKv8829hrqu"
Subject: Re: [Qemu-devel] [PATCH v6 1/7] linker-loader: Add new 'write
 pointer' command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, Ben Warren <ben@skyportsystems.com>
Cc: Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--O0Owis85laWXf0UWjHETNONKv8829hrqu
From: Eric Blake <eblake@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>, Ben Warren <ben@skyportsystems.com>
Cc: Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <05717ea0-dd3b-02bc-7e28-ea25d3f74545@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v6 1/7] linker-loader: Add new 'write
 pointer' command
References: <cover.1487139038.git.ben@skyportsystems.com>
 <9dffe31a245cf6a717eef8227fe80ca666b168b5.1487139038.git.ben@skyportsystems.com>
 <20170215115723.77e4d9d7@nial.brq.redhat.com>
 <1f4a6eb2-0838-2218-88e3-4f65498a41d6@redhat.com>
 <20170215162225.74d48058@nial.brq.redhat.com>
 <20170215172515-mutt-send-email-mst@kernel.org>
 <20170215165602.72e96c28@nial.brq.redhat.com>
 <20170215183736-mutt-send-email-mst@kernel.org>
 <20170215184309.521aa90f@nial.brq.redhat.com>
 <20170215194647-mutt-send-email-mst@kernel.org>
 <20170215192436.2695b9f6@nial.brq.redhat.com>
 <670EAA2E-4A15-475E-99B2-8F3B80A33B7F@skyportsystems.com>
 <D02204A1-30A7-40E0-9ED0-9C734AD8F0B1@skyportsystems.com>
 <20170216121045.6ae68c19@nial.brq.redhat.com>
In-Reply-To: <20170216121045.6ae68c19@nial.brq.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

[meta-comment]

On 02/16/2017 05:10 AM, Igor Mammedov wrote:
> On Wed, 15 Feb 2017 11:19:44 -0800
> Ben Warren <ben@skyportsystems.com> wrote:
>=20
>>> On Feb 15, 2017, at 11:14 AM, Ben Warren <ben@skyportsystems.com> wro=
te:
=2E..
>>>>>>>>>>>>> This is similar to the existing 'add pointer' functionality=
, but instead

13 levels of quoting...

>>>> +        char pad[120]; =20
>>> wr_pointer is 121 (56 + 56 + 32 + 32 + 1), so 124 still makes sense, =
doesn=E2=80=99t it? (also, 124 + 4 from command) % 8 =3D=3D 0, so it=E2=80=
=99s nicely aligned. =20
>> I mean (56 + 56 + 4 + 4 + 1), of course :)
> I' was wrong, as Laszlo pointed out pad is a member of union so it
> as the biggest member defines total size of union/struct
> as far as new command doesn't exceed 124 bytes size.

=2E..and several pages of scrolling before I find the 3-line real content=

of the message...

>>>>>>>>>>>>> #endif         =20

=2E..buried by yet more scrolling through excessive quoting.  It's not
only okay, but ENCOURAGED, to trim your replies down to the relevant
portions (as I've done here), to quickly call attention to the content
you are adding to the thread.  Publicly archived lists have the benefit
that you don't have to full-quote the entire thread, because readers
interested in trimmed content can refer to the archives.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--O0Owis85laWXf0UWjHETNONKv8829hrqu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYpceBAAoJEKeha0olJ0NqYtkH/i1uV9xhPvTCcJkmZ6MYH5/K
gN/n5qOvRj0o1UzVFgmI10GBAvfqmhbHuoNqQbs2BCFcL1Wwey7VCY/L/6/o9jpn
AX+mR56PjfVDEyG/iCrJZT+13Nauf0phIA/tibJLEVEqbNYek+TewJoKJmw/4DXO
rVYH13Wc9FMZaI8INa/5xppjXT2GIjcMKgSh8BYafntZDNUSxjWNwy3taZkk08Qk
6I+rRh+KLi0EaKd+D+o8ThblYixxnI6YFBVdfKvlqQIiXmCeVeI7RYdsZSyuIHX+
1k6P4chOrsWgn30zuOR95VR+4X4Pc5Mq6bpzEGfZeCYLCbinoapO/tmjJ33ARCM=
=XBIP
-----END PGP SIGNATURE-----

--O0Owis85laWXf0UWjHETNONKv8829hrqu--

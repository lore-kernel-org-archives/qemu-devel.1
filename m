Received: from eggs.gnu.org ([2001:4830:134:3::10]:40031)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cekYL-0003BQ-2T
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 10:34:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cekYH-0001zN-Vy
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 10:34:33 -0500
References: <CABHMSTVDnAxAvpp81+z_2fkAFO7tazLJs3cFXpuDuuGQj-Ek-A@mail.gmail.com>
	<1933406e-2576-e687-3545-a72f3b999310@redhat.com>
	<bf1410bc-bc6d-bb29-5591-55634f25d487@redhat.com>
	<CABHMSTUsZy0u4b1b84YC5CgafKvD-Zms5dCQ=31+XnQphUQxLA@mail.gmail.com>
	<20170217064327.GB21716@lemon.lan>
	<CAFEAcA8_f8SVX+rirAFBJ76ZiXaKUwh9uO0AeBFoR7G_q8pGDg@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <6ab86cf8-4780-ca76-f648-ac0ce211e27b@redhat.com>
Date: Fri, 17 Feb 2017 09:34:26 -0600
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8_f8SVX+rirAFBJ76ZiXaKUwh9uO0AeBFoR7G_q8pGDg@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="3BotGn29PrBleMkKjl9uDHnGr1qtrGHWg"
Subject: Re: [Qemu-devel] Fix build break during configuration on musl-libc
 based Linux systems.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Fam Zheng <famz@redhat.com>
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Laszlo Ersek <lersek@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Chad Joan <chadjoan@gmail.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3BotGn29PrBleMkKjl9uDHnGr1qtrGHWg
From: Eric Blake <eblake@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>, Fam Zheng <famz@redhat.com>
Cc: QEMU Trivial <qemu-trivial@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Laszlo Ersek <lersek@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Chad Joan <chadjoan@gmail.com>
Message-ID: <6ab86cf8-4780-ca76-f648-ac0ce211e27b@redhat.com>
Subject: Re: [Qemu-devel] Fix build break during configuration on musl-libc
 based Linux systems.
References: <CABHMSTVDnAxAvpp81+z_2fkAFO7tazLJs3cFXpuDuuGQj-Ek-A@mail.gmail.com>
 <1933406e-2576-e687-3545-a72f3b999310@redhat.com>
 <bf1410bc-bc6d-bb29-5591-55634f25d487@redhat.com>
 <CABHMSTUsZy0u4b1b84YC5CgafKvD-Zms5dCQ=31+XnQphUQxLA@mail.gmail.com>
 <20170217064327.GB21716@lemon.lan>
 <CAFEAcA8_f8SVX+rirAFBJ76ZiXaKUwh9uO0AeBFoR7G_q8pGDg@mail.gmail.com>
In-Reply-To: <CAFEAcA8_f8SVX+rirAFBJ76ZiXaKUwh9uO0AeBFoR7G_q8pGDg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/17/2017 03:28 AM, Peter Maydell wrote:
> On 17 February 2017 at 06:43, Fam Zheng <famz@redhat.com> wrote:
>> But your point is taken, we should make the first (or a one-shot)
>> contribution as easy as possible.
>=20
> Yes; we could do with providing a "This page seems very long..."
> introduction section. The absolute bare minimum requirements
> for a submitter I think are:
>  * Provide a Signed-off-by: line (this is a hard requirement
>    because it's how you say "I'm legally OK to contribute this
>    and am happy for it to go into QEMU")
>  * send patch by email
>  * read replies and act on them if you want your patch to go in
>=20
> The larger your contribution is, the more important the other
> requirements detailed on the page are; but personally I'm
> happy to manually fix up patches from a first-time submitter,
> and I think most other maintainers are too.

I've updated the wiki to put in that nice bullet list, prior to the
table of contents.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--3BotGn29PrBleMkKjl9uDHnGr1qtrGHWg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYpxgCAAoJEKeha0olJ0NqmB8H/jCMqbqyQooSUnKW2HxKuH7X
aZM2hOZt2Vo03PM7pNNGrOab799a1UEpKhoPOMMEb6YgudwdlRt1BA5ilbRMTo+R
JLx3k7bpuWu009gMyPjLpbVLbvgba8PT/y8eC5oNyD5kQ7F6+6y2cl9F3FxtBvwa
aSzu7CkRlSWxy5uxJdQsh+claMwTYSFKbHu/mc5nA4+oFEtcHbOwqrXE9R6z3tiP
RmABvF7chO1zSxw3o9A5Av6Z8eIUh59t1/Q/TBY6C4zVqu+8X1PKlnJb/Vnstixj
GSWmAsiksVuL3MZd7GyiypqsVp3zMSasve9NILAnUiQSxhJothore653KKcdPfI=
=kDbC
-----END PGP SIGNATURE-----

--3BotGn29PrBleMkKjl9uDHnGr1qtrGHWg--

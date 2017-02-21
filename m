Received: from eggs.gnu.org ([2001:4830:134:3::10]:42786)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cg0Zt-0005O5-K7
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 21:53:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cg0Zp-00061h-Mo
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 21:53:21 -0500
References: <CABHMSTVDnAxAvpp81+z_2fkAFO7tazLJs3cFXpuDuuGQj-Ek-A@mail.gmail.com>
	<1933406e-2576-e687-3545-a72f3b999310@redhat.com>
	<bf1410bc-bc6d-bb29-5591-55634f25d487@redhat.com>
	<CABHMSTUsZy0u4b1b84YC5CgafKvD-Zms5dCQ=31+XnQphUQxLA@mail.gmail.com>
	<20170217064327.GB21716@lemon.lan>
	<CAFEAcA8_f8SVX+rirAFBJ76ZiXaKUwh9uO0AeBFoR7G_q8pGDg@mail.gmail.com>
	<6ab86cf8-4780-ca76-f648-ac0ce211e27b@redhat.com>
	<CABHMSTWN2KdAXDjEEbyWio6rNM2FuDk_NUj40mFW0HdyZFu68g@mail.gmail.com>
	<CAFEAcA_N1j9tpxEBROG6D1per9vDMPZeuRyM93BRzNT5ZK3q0Q@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <24a2d084-e391-ae89-8b81-e910871a8edd@redhat.com>
Date: Mon, 20 Feb 2017 20:53:14 -0600
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_N1j9tpxEBROG6D1per9vDMPZeuRyM93BRzNT5ZK3q0Q@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="RIdWaw94ulp0T50BDtOeGWQTbsPbvh2Ea"
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
To: Peter Maydell <peter.maydell@linaro.org>, Chad Joan <chadjoan@gmail.com>
Cc: Fam Zheng <famz@redhat.com>, QEMU Trivial <qemu-trivial@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Laszlo Ersek <lersek@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--RIdWaw94ulp0T50BDtOeGWQTbsPbvh2Ea
From: Eric Blake <eblake@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>, Chad Joan <chadjoan@gmail.com>
Cc: Fam Zheng <famz@redhat.com>, QEMU Trivial <qemu-trivial@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Laszlo Ersek <lersek@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Message-ID: <24a2d084-e391-ae89-8b81-e910871a8edd@redhat.com>
Subject: Re: [Qemu-devel] Fix build break during configuration on musl-libc
 based Linux systems.
References: <CABHMSTVDnAxAvpp81+z_2fkAFO7tazLJs3cFXpuDuuGQj-Ek-A@mail.gmail.com>
 <1933406e-2576-e687-3545-a72f3b999310@redhat.com>
 <bf1410bc-bc6d-bb29-5591-55634f25d487@redhat.com>
 <CABHMSTUsZy0u4b1b84YC5CgafKvD-Zms5dCQ=31+XnQphUQxLA@mail.gmail.com>
 <20170217064327.GB21716@lemon.lan>
 <CAFEAcA8_f8SVX+rirAFBJ76ZiXaKUwh9uO0AeBFoR7G_q8pGDg@mail.gmail.com>
 <6ab86cf8-4780-ca76-f648-ac0ce211e27b@redhat.com>
 <CABHMSTWN2KdAXDjEEbyWio6rNM2FuDk_NUj40mFW0HdyZFu68g@mail.gmail.com>
 <CAFEAcA_N1j9tpxEBROG6D1per9vDMPZeuRyM93BRzNT5ZK3q0Q@mail.gmail.com>
In-Reply-To: <CAFEAcA_N1j9tpxEBROG6D1per9vDMPZeuRyM93BRzNT5ZK3q0Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/17/2017 11:15 AM, Peter Maydell wrote:
> The kernel docs have a longer list of mail clients with
> notes about suitability:
> https://kernel.org/doc/html/latest/process/email-clients.html
> but the set of "just works" clients is very small.

Currently fails with 403 Forbidden

You don't have permission to access
/doc/html/latest/process/email-clients.html on this server.

Hopefully its transient?

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--RIdWaw94ulp0T50BDtOeGWQTbsPbvh2Ea
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYq6uaAAoJEKeha0olJ0NqcjcIAKNm59OYl5PEMNVDwCFI5Y0M
jr2QXIRwoAPXIpqnk3zy3m8409qGEoFODUfSZJkaFGbs/9PtHK+NVahAaHwpXSC4
DyJjvWd4e0w7VpApd0g68hzpy9tR4cqb11Uod9tAhbERsU80hAqYpFNoozVeUyP4
idepLG2YmwibNe/mzFESrDtI6q+RNQN4RIN4O0v+OIJD1YMe9hP4w20Q3+He45bx
o1v0/PHd5/k0+rzzQ8BbtWM/e3X2KOIX5vPI3b5ti9v86J+OHOuJbBgxHnqHA9Rf
KwxB4QyTHNQGccuazBqBeDu9wrvGoZEzm+EPqsPHVqSDLG/W5UPXiO5EkKIPnIQ=
=fFPX
-----END PGP SIGNATURE-----

--RIdWaw94ulp0T50BDtOeGWQTbsPbvh2Ea--

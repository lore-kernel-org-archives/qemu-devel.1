Received: from eggs.gnu.org ([209.51.188.92]:41322)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gotvk-0002sL-Ta
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 12:45:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gotvk-0004pA-1C
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 12:45:44 -0500
References: <20190130173601.3268-1-palmer@sifive.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b9b988df-140e-108d-a80d-48c7ce1b351d@redhat.com>
Date: Wed, 30 Jan 2019 11:45:33 -0600
MIME-Version: 1.0
In-Reply-To: <20190130173601.3268-1-palmer@sifive.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="aPtElfIDd6OXO6w5kTpLfUJXmgNWVnjHu"
Subject: Re: [Qemu-devel] [PR RFC] RISC-V Patches for 3.2, Part 3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Palmer Dabbelt <palmer@sifive.com>, qemu-riscv@nongnu.org
Cc: qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--aPtElfIDd6OXO6w5kTpLfUJXmgNWVnjHu
From: Eric Blake <eblake@redhat.com>
To: Palmer Dabbelt <palmer@sifive.com>, qemu-riscv@nongnu.org
Cc: qemu-devel@nongnu.org
Message-ID: <b9b988df-140e-108d-a80d-48c7ce1b351d@redhat.com>
Subject: Re: [Qemu-devel] [PR RFC] RISC-V Patches for 3.2, Part 3
References: <20190130173601.3268-1-palmer@sifive.com>
In-Reply-To: <20190130173601.3268-1-palmer@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/30/19 11:35 AM, Palmer Dabbelt wrote:
> The following changes since commit 5385a5988c8a55bebdc878c05b96648579b5=
d6e0:
>=20
>   hw/virtio/virtio-balloon: zero-initialize the virtio_balloon_config s=
truct (2019-01-21 17:20:36 +0000)
>=20
> are available in the Git repository at:
>=20
>   git://github.com/palmer-dabbelt/qemu.git tags/riscv-for-master-3.2-pa=
rt3
>=20
> for you to fetch changes up to 461ab9de46d085a37b0da6f096aadc4e0dda4d4c=
:
>=20
>   target/riscv: fix counter-enable checks in ctr() (2019-01-29 11:33:38=
 -0800)
>=20
> ----------------------------------------------------------------
> RISC-V Patches for 3.2, Part 3

There is no 3.2 release; the next release is named 4.0.  However, if you
don't want to bother with sending a v2 pull request just to fix the
merge commit message, that's okay with me.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--aPtElfIDd6OXO6w5kTpLfUJXmgNWVnjHu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxR4r0ACgkQp6FrSiUn
Q2oFqQf5ASzoPgmptcojZxRZYwJlLlKK1oM6IcGlzM6y8OBA8hiQilF6RqiIgeRw
uYVQsm5ltuFGkZjQ0i5yuCvZDBxgNVK9UJ62rGaPih1VuVCujhnS6V6y9oZEO1kC
0AC0waekcaKjHiSP+/3fD5wfti8G8kz5KtXKcS/uahMKkYjAyx713z3I9DlbcWhi
o6MSQJdC5m6zgY0JbqdZz3poXvr/0fw4vd0icJThnkOka7py7nkQh8c8b9ehQhzd
klKQ3iA+qh3sd7WQYALsv26cZqHEwNQx0lBi2CtTZ/innRcJ+os9dDRFJJlwp2Op
un2ntMGvxDexJA+NW5rQ4CWj1k2Wdw==
=fwCm
-----END PGP SIGNATURE-----

--aPtElfIDd6OXO6w5kTpLfUJXmgNWVnjHu--

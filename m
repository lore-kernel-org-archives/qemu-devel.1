Received: from eggs.gnu.org ([2001:4830:134:3::10]:38627)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f3ib0-00036h-QX
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 09:37:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f3iax-0001dd-MG
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 09:37:02 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38456 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1f3iax-0001cv-H5
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 09:36:59 -0400
References: <20180403193420.2065215-1-eblake@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <58fed860-2372-55d5-6b0e-3f0cf9f54e8a@redhat.com>
Date: Wed, 4 Apr 2018 08:36:58 -0500
MIME-Version: 1.0
In-Reply-To: <20180403193420.2065215-1-eblake@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="2tzF4XYgVQ2vQgWEvamOfXiBrDOOEizxk"
Subject: Re: [Qemu-devel] [PULL 0/3] QAPI and misc patches for 2.12-rc2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2tzF4XYgVQ2vQgWEvamOfXiBrDOOEizxk
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Message-ID: <58fed860-2372-55d5-6b0e-3f0cf9f54e8a@redhat.com>
Subject: Re: [Qemu-devel] [PULL 0/3] QAPI and misc patches for 2.12-rc2
References: <20180403193420.2065215-1-eblake@redhat.com>
In-Reply-To: <20180403193420.2065215-1-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/03/2018 02:34 PM, Eric Blake wrote:
> The following changes since commit 13b65ec54dbf524cb62331281a98b432f78d=
4e3a:
>=20
>   Merge remote-tracking branch 'remotes/ericb/tags/pull-nbd-2018-04-02'=
 into staging (2018-04-03 15:59:50 +0100)
>=20
> are available in the Git repository at:
>=20
>   git://repo.or.cz/qemu/ericb.git tags/pull-qapi-2018-04-03
>=20
> for you to fetch changes up to 1ecaef92a1d158bd875bf66091325d4721eb2762=
:
>=20
>   dump: Fix build with newer gcc (2018-04-03 13:47:08 -0500)

v2 pull request sent to add one more patch

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--2tzF4XYgVQ2vQgWEvamOfXiBrDOOEizxk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlrE1PoACgkQp6FrSiUn
Q2oEeQf/RO+ZOsEytMLLiyKy6DeVjlj/XM/iqhQakL1y3HsEEvJfEA1vvswQfSsN
6il2bLX/AqBDWxTbnamR58EQkTpcMaxsgSg0txilvMu3ualK+j2T3jVPGmiU+Iom
LUjrY8uB8jwxpsBQUQFV185Jq/+nZbfogS8NkcgYivA1iY+31wbavOAY+Keqk8kV
mIC0o+inxaOuj849roeE7dEaQ9uHjZ4bk4dd7/gsOqWw6gLNqFXHAkFWD5+bsQS5
AwDH1cUEeT0B00UimsqmLzhq5u2LU3RMMn/bvCcbN/VZiSn6et6NzGNA3QS56nIe
l4VIFsFyhF108MpYexiCGVi7BCI53Q==
=D/5Q
-----END PGP SIGNATURE-----

--2tzF4XYgVQ2vQgWEvamOfXiBrDOOEizxk--

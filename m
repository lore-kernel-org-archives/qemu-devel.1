Received: from eggs.gnu.org ([2001:4830:134:3::10]:40064)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dVI8s-0000dt-12
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 09:57:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dVI8r-0001KS-65
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 09:57:26 -0400
References: <cover.1499866676.git.mjt@msgid.tls.msk.ru>
From: Eric Blake <eblake@redhat.com>
Message-ID: <47cedaad-93e6-fc94-0bc2-278e2eea25e2@redhat.com>
Date: Wed, 12 Jul 2017 08:57:20 -0500
MIME-Version: 1.0
In-Reply-To: <cover.1499866676.git.mjt@msgid.tls.msk.ru>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Q0fHUFTSxaJbLprqSVlDwuOgv51veKv7U"
Subject: Re: [Qemu-devel] [PULL 00/13] Trivial patches for 2017-07-12
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Q0fHUFTSxaJbLprqSVlDwuOgv51veKv7U
From: Eric Blake <eblake@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org
Message-ID: <47cedaad-93e6-fc94-0bc2-278e2eea25e2@redhat.com>
Subject: Re: [Qemu-devel] [PULL 00/13] Trivial patches for 2017-07-12
References: <cover.1499866676.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1499866676.git.mjt@msgid.tls.msk.ru>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/12/2017 08:37 AM, Michael Tokarev wrote:
> The following changes since commit 6b06e3e49eb8c91cc286c16d6bf3181ac296=
f33d:
>=20
>   Merge remote-tracking branch 'remotes/ericb/tags/pull-nbd-2017-07-10-=
v2' into staging (2017-07-10 16:12:47 +0100)
>=20
> are available in the git repository at:
>=20
>   git://git.corpit.ru/qemu.git tags/trivial-patches-fetch
>=20
> for you to fetch changes up to 10cb4ec41734243b2798bd1d53919827eaccd673=
:
>=20
>   qobject: Update coccinelle script to catch Q{INC, DEC}REF (2017-07-12=
 16:34:44 +0300)
>=20
> ----------------------------------------------------------------
> trivial patches for 2017-07-12
>=20
> ----------------------------------------------------------------
> Eric Blake (2):
>       qobject: Catch another straggler for use of qdict_put_str()
>       qobject: Update coccinelle script to catch Q{INC, DEC}REF

You picked up v1 of these patches, when Markus was already planning on
merging v2.  It may be easier to respin a v2 of the pull request that
drops these patches from -trivial.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--Q0fHUFTSxaJbLprqSVlDwuOgv51veKv7U
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZZirAAAoJEKeha0olJ0Nq8C0H/A+iuTZ7huY6jOadXmVJZ+Z5
9uO1DQ2iH9AkpDCIG6JaYW+JVKaqs1xPt7Ldkw72rhxBDwZNS4UQJhWeMo8mpcGN
t6bFUnzoRgFcawXdzYO+WlVFfgYxBptc9eoH9EUmuSNVLuCg/BXqMynzOjG2N49R
HFVcwHFaWw1iTsmngmuxgJyFi/Sjcm36CSBp7CZbjLlz19oIzTR4gitAbBWXulY+
/Iwjykph6Kfprxac427i/q5u/I0UIk9zX6tdS4lK/jGSYzSgMEhMbLtyjSaLNUcz
VgMHBeorLRXY860IhnYYHsDrRgR39AOwxx1R6j0soUSIMKrFDmr+0XopVk6HbW0=
=H5Ei
-----END PGP SIGNATURE-----

--Q0fHUFTSxaJbLprqSVlDwuOgv51veKv7U--

Received: from eggs.gnu.org ([209.51.188.92]:41009)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gmizd-0005Tt-4q
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 12:40:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gmizc-0004ap-2F
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 12:40:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52858)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gmizb-0004ZC-Od
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 12:40:43 -0500
References: <20190121144841.24467-1-anthony.perard@citrix.com>
	<CAFEAcA_ytAb-K-HB3wL5baMBDkY71ksBK8hsUSFxuUeqVDFyHQ@mail.gmail.com>
	<804f8429-d3f6-dc1a-4980-fc5a44a6b3c5@msgid.tls.msk.ru>
	<87fttijvfm.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <9a1725c3-1119-886d-2d9d-11369ea5f207@redhat.com>
Date: Thu, 24 Jan 2019 11:40:39 -0600
MIME-Version: 1.0
In-Reply-To: <87fttijvfm.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="EZMrlU14vgKzwnjOGYDndQImM3kxp6W7t"
Subject: Re: [Qemu-devel] [PATCH] configure: Don't add Xen's libs to LDFLAGS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Cc: Peter Maydell <peter.maydell@linaro.org>, Stefano Stabellini <sstabellini@kernel.org>, QEMU Developers <qemu-devel@nongnu.org>, Paul Durrant <paul.durrant@citrix.com>, Anthony PERARD <anthony.perard@citrix.com>, "open list:X86" <xen-devel@lists.xenproject.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--EZMrlU14vgKzwnjOGYDndQImM3kxp6W7t
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Paul Durrant <paul.durrant@citrix.com>,
 Anthony PERARD <anthony.perard@citrix.com>,
 "open list:X86" <xen-devel@lists.xenproject.org>
Message-ID: <9a1725c3-1119-886d-2d9d-11369ea5f207@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] configure: Don't add Xen's libs to LDFLAGS
References: <20190121144841.24467-1-anthony.perard@citrix.com>
 <CAFEAcA_ytAb-K-HB3wL5baMBDkY71ksBK8hsUSFxuUeqVDFyHQ@mail.gmail.com>
 <804f8429-d3f6-dc1a-4980-fc5a44a6b3c5@msgid.tls.msk.ru>
 <87fttijvfm.fsf@dusky.pond.sub.org>
In-Reply-To: <87fttijvfm.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/24/19 2:45 AM, Markus Armbruster wrote:

>> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
>> Revieved-by: Michael Tokarev <mjt@tls.msk.ru>
>=20
> Typo in Reviewed-by.

Should we tighten checkpatch.pl to flag suspicious-looking 'xxx-by:'
tags, to catch instances of typos?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--EZMrlU14vgKzwnjOGYDndQImM3kxp6W7t
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxJ+JcACgkQp6FrSiUn
Q2rIUQf6A4gzFoPMRvjHDslsPb4H+ZRXfMdW2IHug5577b+c7+S23SPRHAV+yZvl
kxzCIiVo3/Qq8MwPjSgJAIQ4xXxTYCr+/VPsUWB3QkPGjMI+m3WdDnPL4L2PO1Eb
eMUePef4z+/LZMtD5FBwFAiMTol8ie3OSpjW67m/081s9ljQrbiCE9x8S5UfQyms
M9p/Z3UES89dq0AqXIvZcJ0KltruA/8+bDHUegKdlTZqnADQLCNBz+AkEEPTw1Hi
5kzVJBPTwHUy1XfBDKDshlNy2dFLWobKVS3+u4IsqDizPeLGFTkuBAxaEF2HN8di
Kt5220nYHXSIKf5+a4e16K6gk3+lmg==
=a84x
-----END PGP SIGNATURE-----

--EZMrlU14vgKzwnjOGYDndQImM3kxp6W7t--

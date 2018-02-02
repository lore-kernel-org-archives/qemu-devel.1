Received: from eggs.gnu.org ([208.118.235.92]:48108)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ehfUk-00069C-3j
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 12:52:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ehfTf-0002u8-6V
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 12:51:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45768)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ehfTe-0002qx-Il
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 12:50:18 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 562485B303
	for <qemu-devel@nongnu.org>; Fri,  2 Feb 2018 17:50:17 +0000 (UTC)
References: <20180202071751.16316-1-kraxel@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a9e4deb4-5162-19a1-324e-640abd272fc3@redhat.com>
Date: Fri, 2 Feb 2018 11:49:55 -0600
MIME-Version: 1.0
In-Reply-To: <20180202071751.16316-1-kraxel@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="4w5TDFA4poRu1tzohhdMT63W2PYgVLhkd"
Subject: Re: [Qemu-devel] [PULL 0/3] Ui 20180202 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org, "Daniel P. Berrange" <berrange@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--4w5TDFA4poRu1tzohhdMT63W2PYgVLhkd
From: Eric Blake <eblake@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org,
 "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <a9e4deb4-5162-19a1-324e-640abd272fc3@redhat.com>
Subject: Re: [Qemu-devel] [PULL 0/3] Ui 20180202 patches
References: <20180202071751.16316-1-kraxel@redhat.com>
In-Reply-To: <20180202071751.16316-1-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/02/2018 01:17 AM, Gerd Hoffmann wrote:
> The following changes since commit 11ed801d3df3c6e46b2f1f97dcfbf4ca3a2a=
2f4f:
>=20
>   Merge remote-tracking branch 'remotes/stefanha/tags/tracing-pull-requ=
est' into staging (2018-01-30 09:47:51 +0000)
>=20
> are available in the git repository at:
>=20
>   git://git.kraxel.org/qemu tags/ui-20180202-pull-request
>=20
> for you to fetch changes up to 627ebec208a8809818589e17f4fce55a59420ad2=
:
>=20
>   ui: correctly advance output buffer when writing SASL data (2018-02-0=
2 07:48:18 +0100)
>=20
> ----------------------------------------------------------------
> ui: use QIONetListener in vnc, bugfixes for sdl1 and vnc.
>=20
> ----------------------------------------------------------------
>=20
> Daniel P. Berrange (1):
>   ui: convert VNC server to QIONetListener
>=20
> Daniel P. Berrang=C3=A9 (2):

Odd effects based on choice of UTF-8 spellings.  Dan, do you want to add
a .mailmap entry to consolidate on a single preferred form of your name?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--4w5TDFA4poRu1tzohhdMT63W2PYgVLhkd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlp0pMMACgkQp6FrSiUn
Q2pNkgf/fK2mz/vF1OVVqmSQzCyiLq3HnzxYJdqgjQrMwb1bumJ3owIM2uzBMiwD
M/FA/NjU3O7bkPzI1yP9lud28/I7YuEhI+uiuALCnIJZpW+0FK6+soURkioAXYbw
47dz2pGnQAAeqeUEkmXgKKb6x41ghOurQmXaa7jJG5zUzsPvG56Spnz1pENJMsUv
KmsrCcTxERBdQgWqtZl033A4Rofqnr2wUVN4l0bouA+xBJVbpC/AU1l5rOEiBu8S
XyJmSGt/bKsYIJGhWi43D51yQ3I+eKu66aROTY3scdnI5JwGN7hmacNLBpu2ab56
dXFmYu4RpLhW8oWmqUhqJ7gKpRvwFg==
=xDl/
-----END PGP SIGNATURE-----

--4w5TDFA4poRu1tzohhdMT63W2PYgVLhkd--

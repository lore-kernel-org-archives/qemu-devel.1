Received: from eggs.gnu.org ([2001:4830:134:3::10]:41113)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f3ijP-00025E-MH
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 09:45:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f3ijL-0005ZF-1Z
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 09:45:43 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46562 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1f3ijK-0005YV-SM
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 09:45:38 -0400
References: <20180326150916.9602-1-marcandre.lureau@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <73aa8f1a-31dd-f7d1-2210-1082edc277d9@redhat.com>
Date: Wed, 4 Apr 2018 08:45:32 -0500
MIME-Version: 1.0
In-Reply-To: <20180326150916.9602-1-marcandre.lureau@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="wCo5WIMu31MYs2eJ9b1JUVW5vJxVsG4Pt"
Subject: Re: [Qemu-devel] [PATCH v3 00/38] RFC: monitor: add asynchronous
 command type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Cleber Rosa <crosa@redhat.com>, Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--wCo5WIMu31MYs2eJ9b1JUVW5vJxVsG4Pt
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela
 <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>
Message-ID: <73aa8f1a-31dd-f7d1-2210-1082edc277d9@redhat.com>
Subject: Re: [PATCH v3 00/38] RFC: monitor: add asynchronous command type
References: <20180326150916.9602-1-marcandre.lureau@redhat.com>
In-Reply-To: <20180326150916.9602-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/26/2018 10:08 AM, Marc-Andr=C3=A9 Lureau wrote:
> Hi,
>=20
> One of initial design goals of QMP was to have "asynchronous command
> completion" (http://wiki.qemu.org/Features/QAPI). Unfortunately, that
> goal was not fully achieved, and some broken bits left were removed
> progressively until commit 65207c59d that removed async command
> support.
>=20

> v3:
> - complete rework, dropping the asynchronous commands visibility from
>   the protocol side entirely (until there is a real need for it)
> - rebased, with a few preliminary cleanup patches

Are any of the preliminary cleanup patches appropriate for 2.12 as bug
fixes?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--wCo5WIMu31MYs2eJ9b1JUVW5vJxVsG4Pt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlrE1vwACgkQp6FrSiUn
Q2qfSQgAo2V7LVXk8OeqdOwy7zdux0LH/dn78qI0D7tLSdXgJA/TIvKYlwDWu9gF
skVjjqr+zae3SHdI0Ep90taUn0UJFL0r8nVLN+hHpFk0xhQgPLlIEvMCcrHEsmY4
tfMdWzOWmEtDBmv7m1gnRwoOQ1yxayAq3e3bdIb840aGM9PmfnNy1djScVKuTcZl
oB9rDItJ2uXUGpDEauCneegfODKtLiJCUpICIJPuflTedbMHVTtCD7w3TR1B2O3/
GETVG0mNU6r45ZkgRnSZmBeyQiX/JkDsaWzpbZktCxlBuw33SOJKV6qc4xASa3Hv
WrxMN+zD+3lROPP8owDmRZObj9hOQA==
=iySw
-----END PGP SIGNATURE-----

--wCo5WIMu31MYs2eJ9b1JUVW5vJxVsG4Pt--

Received: from eggs.gnu.org ([2001:4830:134:3::10]:41633)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dz2kE-00071a-LR
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 11:34:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dz2kA-0004mc-Ow
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 11:34:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59472)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dz2kA-0004m7-Fg
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 11:34:54 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 63371883C4
	for <qemu-devel@nongnu.org>; Mon,  2 Oct 2017 15:34:53 +0000 (UTC)
References: <20171002140307.5292-1-armbru@redhat.com>
	<20171002140307.5292-8-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <9023e0ae-40ed-558a-9de4-3529ce142774@redhat.com>
Date: Mon, 2 Oct 2017 10:34:48 -0500
MIME-Version: 1.0
In-Reply-To: <20171002140307.5292-8-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="KfHfuriUrVxe7mVERkVBdu1Ld4smVSdi3"
Subject: Re: [Qemu-devel] [PATCH 7/8] qemu-options: Polish section
 "Character device options"
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
List-ID: <qemu-devel.nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--KfHfuriUrVxe7mVERkVBdu1Ld4smVSdi3
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Message-ID: <9023e0ae-40ed-558a-9de4-3529ce142774@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 7/8] qemu-options: Polish section "Character
 device options"
References: <20171002140307.5292-1-armbru@redhat.com>
 <20171002140307.5292-8-armbru@redhat.com>
In-Reply-To: <20171002140307.5292-8-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/02/2017 09:03 AM, Markus Armbruster wrote:
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> CC: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  qemu-options.hx | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--KfHfuriUrVxe7mVERkVBdu1Ld4smVSdi3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnSXJkACgkQp6FrSiUn
Q2pUGAf/VVPUz6bcHXbN/nzuQ4hoCy7JuUAt/zn3Nvt6h8OJzrWfIarxllntKpv0
PaYWNRw4K1f1KmCExq22rO1Mn3o4+apjE6W0BcwrNueqebfSJ0WDArn/qs9fe83H
grVZjgoCiPdswU7EKyX/33bWHZrbRfTHUYpph+ZWCmHX/yKYlHVwMoWA0aESLk8l
3OvNrXX/tDTAJljhn8o1WSzM2DD/NPa2lzdtY2nh0RJfslN6sjrc6ayi/trQPayT
kUap+RnZV7tfg//dFQUgdgv/gpqxpUjtna4xqnbwMagZoEl6g83GayL3ObqO2+bL
Z6Nwxj24/E9IA+oAVj+zrc2feR1ujA==
=Zq5e
-----END PGP SIGNATURE-----

--KfHfuriUrVxe7mVERkVBdu1Ld4smVSdi3--

Received: from eggs.gnu.org ([2001:4830:134:3::10]:37141)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dZc95-0001Kl-Mw
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 08:07:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dZc92-0003ey-IK
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 08:07:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54516)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dZc92-0003ei-9c
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 08:07:28 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 56BB2356DA
	for <qemu-devel@nongnu.org>; Mon, 24 Jul 2017 12:07:27 +0000 (UTC)
Received: from [10.10.121.48] (ovpn-121-48.rdu2.redhat.com [10.10.121.48])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 0F3B1702E1
	for <qemu-devel@nongnu.org>; Mon, 24 Jul 2017 12:07:26 +0000 (UTC)
References: <20170721135047.25005-1-eblake@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d410f903-f786-a112-8281-7d7162ec2569@redhat.com>
Date: Mon, 24 Jul 2017 07:07:26 -0500
MIME-Version: 1.0
In-Reply-To: <20170721135047.25005-1-eblake@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="P3gJ97cQ8G7nV2rfWF5nI8m32Gg5ODXGu"
Subject: Re: [Qemu-devel] [PATCH for-2.10 0/2] Update qemu-nbd version
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--P3gJ97cQ8G7nV2rfWF5nI8m32Gg5ODXGu
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Message-ID: <d410f903-f786-a112-8281-7d7162ec2569@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.10 0/2] Update qemu-nbd version
References: <20170721135047.25005-1-eblake@redhat.com>
In-Reply-To: <20170721135047.25005-1-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/21/2017 08:50 AM, Eric Blake wrote:
> =E9=99=B3=E5=9F=B9=E6=B3=93 reported that 'qemu-nbd -V' was stuck at 0.=
0.1; fix that,
> along with a nearby style issue noticed in the process.  Not
> having a useful version number is a bug in my eyes, so I'm
> proposing this series for 2.10.
>=20
> Eric Blake (2):
>   qemu-nbd: Update version string
>   maint: Reorder include directives for qemu-{nbd,io}

Thanks; queued on my NBD branch:
git://repo.or.cz/qemu/ericb.git nbd

>=20
>  qemu-img.c |  3 ++-
>  qemu-nbd.c | 13 +++++++------
>  2 files changed, 9 insertions(+), 7 deletions(-)
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--P3gJ97cQ8G7nV2rfWF5nI8m32Gg5ODXGu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAll14v4ACgkQp6FrSiUn
Q2p2FAgAmA+iM8gs8Vysbxw2RqMI6zNntoG4V0w1OhZLOcgZmYo6nn1+YQLBeQkD
kkHBr0lAiIGvL7EufJY2X908IDu92QgPMZtI95PvHR14mTxOy81lK+71KpHFm4lv
7puNjSgPhZq2gJcsolbbz3Lmkacgz1nqcG39W7m7D3JvISIHn5QTM6XUQNX6NRMe
gBM4Vkb9fSH2Z0OE1eDU3oEJI6tutScTZY6ZOElhOHYsoW4IcBE0dSQUK89om2GW
+QmWzahVihYVCbbvTEmXFT5sFT6QvDWFFckRJ4A4sq6Rl3FDEF4XUFDFOfyKyuWq
YJToF3dGz4wk7v8AxuV6qce3Iamypw==
=E9h8
-----END PGP SIGNATURE-----

--P3gJ97cQ8G7nV2rfWF5nI8m32Gg5ODXGu--

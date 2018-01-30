Received: from eggs.gnu.org ([2001:4830:134:3::10]:47494)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1egZ0T-0007mO-CW
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 11:43:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1egZ0Q-0004Tp-AL
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 11:43:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40162)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1egZ0Q-0004Tg-3o
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 11:43:34 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 47A5F776C3
	for <qemu-devel@nongnu.org>; Tue, 30 Jan 2018 16:43:33 +0000 (UTC)
References: <20180130102202.28519-1-armbru@redhat.com>
	<20180130102202.28519-6-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <9a610949-05ea-753b-296f-1d1e79c1a379@redhat.com>
Date: Tue, 30 Jan 2018 10:43:31 -0600
MIME-Version: 1.0
In-Reply-To: <20180130102202.28519-6-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="WIniMsKuT8iEqzQIGGAsgnFYdAbILoFgh"
Subject: Re: [Qemu-devel] [PATCH 05/18] Include qmp-commands.h exactly where
 needed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--WIniMsKuT8iEqzQIGGAsgnFYdAbILoFgh
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Message-ID: <9a610949-05ea-753b-296f-1d1e79c1a379@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 05/18] Include qmp-commands.h exactly where
 needed
References: <20180130102202.28519-1-armbru@redhat.com>
 <20180130102202.28519-6-armbru@redhat.com>
In-Reply-To: <20180130102202.28519-6-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/30/2018 04:21 AM, Markus Armbruster wrote:
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--WIniMsKuT8iEqzQIGGAsgnFYdAbILoFgh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpwoLQACgkQp6FrSiUn
Q2oDEQf9FxVxnxoMlE/dbqRix0x3vIM262ibL0llJMBE9FXPzTqFceN5HUJjVWpd
9GU1aypiAEEDW3v6uj/Ed8abRhgHvO1pBVD6gq3YUpc5jLsTmj+ixp9SawOKDSOC
MlinLlYrASkEQGLOTRf8rH47OYZU69AlmB4608MoE4gM3EMxQjSWVQkDqYBWm2xO
DVwXAUwD4D3rtv2dsPUGvZZ8EEy/AjGx5qil4hccyiaCWSusZX3psYJoQzR9s/Tq
HWF/dBiSaLAjFUd743GQRBlNl74gBTdq6s9X5qo9RNGR/gUHgTgXaVVH4S65zGjW
oAxPyGmYXzp4MTJBgQ2rfZpfnfZFag==
=7wi9
-----END PGP SIGNATURE-----

--WIniMsKuT8iEqzQIGGAsgnFYdAbILoFgh--

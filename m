Received: from eggs.gnu.org ([2001:4830:134:3::10]:55014)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dfpDr-0001Ds-BN
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 11:18:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dfpDo-0001Ip-1X
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 11:18:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53844)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dfpDn-0001IO-RM
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 11:18:03 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DB0DDA723
	for <qemu-devel@nongnu.org>; Thu, 10 Aug 2017 15:18:02 +0000 (UTC)
References: <20170808162629.32493-1-quintela@redhat.com>
	<20170808162629.32493-5-quintela@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e8730e2f-c0e9-5c6e-9a2e-6214c180c087@redhat.com>
Date: Thu, 10 Aug 2017 10:17:57 -0500
MIME-Version: 1.0
In-Reply-To: <20170808162629.32493-5-quintela@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="u6UsXp1X9aHowHO0GW7KXMKtpQODT3XEX"
Subject: Re: [Qemu-devel] [PATCH v6 04/19] migration: Create
 migration_has_all_channels
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: lvivier@redhat.com, dgilbert@redhat.com, peterx@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--u6UsXp1X9aHowHO0GW7KXMKtpQODT3XEX
From: Eric Blake <eblake@redhat.com>
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: lvivier@redhat.com, dgilbert@redhat.com, peterx@redhat.com
Message-ID: <e8730e2f-c0e9-5c6e-9a2e-6214c180c087@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v6 04/19] migration: Create
 migration_has_all_channels
References: <20170808162629.32493-1-quintela@redhat.com>
 <20170808162629.32493-5-quintela@redhat.com>
In-Reply-To: <20170808162629.32493-5-quintela@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/08/2017 11:26 AM, Juan Quintela wrote:
> This functions allows us to decide when to close the listener socket.

s/functions/function/

> For now, we only need one connection.
>=20
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--u6UsXp1X9aHowHO0GW7KXMKtpQODT3XEX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmMeSUACgkQp6FrSiUn
Q2q9JAf/RHMYe72vMNs/GMsJSyED07+pYeWpoRCtcf782bPA2UEGciV/Rgq73uMt
+bZF6T7fHWtp+wGdh3ysAJ7NoM2TLHYp1QSuapc7HYcUgMBd7PxoK//pJe90Fk0f
ns3RRiHy0OXhpIg7jb3snBFivZaOB++Y/iG+YhpoIEb4CGUWbYy17fb6almY503v
PGvzKO2R8arafps0RBoCAE0jfSQPYj+idc/xeouzX6DNC4kGHY4FePqF4uzDmX78
hXlX2PNbMOmwPSqMrvYHF00/WVoYQ86HaTP5d08nkgHAOuF/PfKg4QfEbgAqVkRJ
tZrxNpx91IaZGDm91gEDgTIJqjeC8w==
=MOSW
-----END PGP SIGNATURE-----

--u6UsXp1X9aHowHO0GW7KXMKtpQODT3XEX--

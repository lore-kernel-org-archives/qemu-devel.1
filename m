Received: from eggs.gnu.org ([2001:4830:134:3::10]:59829)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eoXWD-000430-BA
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 11:45:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eoXWA-0001Q7-0C
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 11:45:21 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52588 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1eoXW9-0001Q0-Qd
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 11:45:17 -0500
Date: Wed, 21 Feb 2018 16:45:09 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180221164509.GD21436@stefanha-x1.localdomain>
References: <20180124053957.29145-1-peterx@redhat.com>
	<20180124053957.29145-13-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2Z2K0IlrPCVsbNpk"
Content-Disposition: inline
In-Reply-To: <20180124053957.29145-13-peterx@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v7 12/23] monitor: let suspend_cnt be
 thread safe
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <shajnocz@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>, marcandre.lureau@redhat.com, "Dr . David Alan Gilbert" <dgilbert@redhat.com>


--2Z2K0IlrPCVsbNpk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Nevermind, I see the next patch adds QMP support.

Stefan

--2Z2K0IlrPCVsbNpk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJajaIVAAoJEJykq7OBq3PIOj0IALlpqbWmifEkGXjFHUH63Pqa
aIIWT6e0KxY/QdT9hqr7BJWcIs7EVle9Bfj8mZOtcX3roHP6dQnupYDteguKUu3d
GrlgqBpw3phwfAQY1OIpdw9+XzrnNtM14fMj9FxeOqxDCwnyKF/SELbaV9PImyb2
U/SYBkqokG7U/MY1a+dVnb90go18Vv6U4YeRCAKUJiANwJjaSQmsmLo/02hW7n8m
1jXk0rhKxc+XCJHzbuvsqK761nDnX5Qtk3OTLkbnEpB0HUfVIcDO8eGjcdfmw8m3
3rSSVJjMpYNEFj0Xkuh8J7PM1QkPofzNcIiJnd0JfRQMKhoY7MgsB424QfOgcbE=
=9sUj
-----END PGP SIGNATURE-----

--2Z2K0IlrPCVsbNpk--

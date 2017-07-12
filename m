Received: from eggs.gnu.org ([2001:4830:134:3::10]:40161)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dV6oN-0006d1-Uy
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 21:51:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dV6oK-0001X6-TG
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 21:51:32 -0400
Date: Wed, 12 Jul 2017 11:51:18 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170712015118.GL4083@umbus.fritz.box>
References: <20170711180755.21017-1-danielhb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="dpynvXbW/eW9Tpc3"
Content-Disposition: inline
In-Reply-To: <20170711180755.21017-1-danielhb@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v15] migration: spapr: migrate
 pending_events of spapr state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, mdroth@linux.vnet.ibm.com


--dpynvXbW/eW9Tpc3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Applied to ppc-for-2.10, though I'm going to make some minor followup
cleanups.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--dpynvXbW/eW9Tpc3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZZYCTAAoJEGw4ysog2bOSBH4P/0o+dfTGDc0KjYeOywivzxGc
UgjbaeBpJlvSSC5uDx7wrosR54mCOwbTJ4ssqY2XfYd0AdsOTt1H9Ua2Cn/Uwg4R
6QJQQ6Qgh5AF9CkkmTEJOpofr/cb1nLSRK7po1aXK37M9j7nQBbU5lVI+vGJ6MOc
qFe6TkRYjT5ENWN2+Xv1mIuX9OIAY3qGGcxYXLVaNH4CQxHnQtswko/Vl76GsimE
eR0mRicGI5NGb2C0wB04YUrjy6MSxGwot7biy72TmVEgPCO1KGyqC4K/o9eOfCoI
JLxCjP1qHsT4MgkzV6d+gkXp5EThkqEl8KQbmC3OsST4+eg9+DG0GwBLqDxTchPd
/lAajnOnRadWLiYnpuVO1+BNWDrDaPL7HOHfIau27r4mbz8LjUo82iVheAvEpj/k
mTeOy2AKxcbyjNF5SUx58WBiAsRFeWgW9vr502kX9uJGyB0MKOuj0E9AxoezFLD1
s0CMk/+LqyXmi+cByi5fMb8qmCWZ7Ar4E4sU0ckQh6LXNLeOQbcG0mn1WRtamQl4
raEBd0bhzgz3gNzlALJt/9aW/ssJeSKAegb629ArAHEraIr/RSskmcDP6Ymkj6f5
KhCUhDzDoh/wmbeh3cnDoaJnjPazRJcm/YnN7p5lmtuT8rgGQHC0MaBSpGvkVrH7
kl04Op2Ioe2C9uLRC5at
=I5Ze
-----END PGP SIGNATURE-----

--dpynvXbW/eW9Tpc3--

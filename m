Received: from eggs.gnu.org ([2001:4830:134:3::10]:52813)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eduardo.otubo@profitbricks.com>) id 1cJzre-0004hE-57
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 04:40:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eduardo.otubo@profitbricks.com>) id 1cJzrZ-0007jU-7C
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 04:40:42 -0500
Received: from mail-wj0-x234.google.com ([2a00:1450:400c:c01::234]:35994)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <eduardo.otubo@profitbricks.com>)
	id 1cJzrY-0007fV-UO
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 04:40:37 -0500
Received: by mail-wj0-x234.google.com with SMTP id c11so18244175wjx.3
	for <qemu-devel@nongnu.org>; Thu, 22 Dec 2016 01:40:33 -0800 (PST)
Received: from vader ([62.217.45.26]) by smtp.gmail.com with ESMTPSA id
	v2sm34755703wja.41.2016.12.22.01.40.31 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 22 Dec 2016 01:40:31 -0800 (PST)
Date: Thu, 22 Dec 2016 10:40:29 +0100
From: Eduardo Otubo <eduardo.otubo@profitbricks.com>
Message-ID: <20161222094029.GA1571@vader>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="liOOAslEiF7prFVr"
Content-Disposition: inline
Subject: [Qemu-devel] CPU hotplug on Windows 2016 as guest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org


--liOOAslEiF7prFVr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi guys,

I'm just trying Qemu 2.7 and 2.8 and Windows 2016 as guest and cpu
hotplug doesn't seem to be working. CPU appears on qemu device tree, but
doesn't appear inside the guest (nor control panel, performance monitor
or device manager)

Anyone going through this?

--=20
Eduardo Otubo
ProfitBricks GmbH

--liOOAslEiF7prFVr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEcBAEBAgAGBQJYW5+NAAoJEP0M/1sS+L0v/X8IAJR0MaSryEB8p6tbprwUmlKn
1oerQ/YIb+DI6sxqf6Xu0sKlI8DWFAt2+pVGUK5AnGQBMZqkEV5ETvxNTNXSrOJH
+jErGiH8NTRoFu6L5K09Flrtbr7Y0CQvV6tZsT5ANSxd39AsQKwuhFHTUOrR4p84
vqSwU1sFFq1B2MZYluDaGdh12twod/jJrvzDMcYQ289runKc+b5xFAb/OgjJpSRC
avQ6YNm9gi0TPOGvzjAgAHfrr6+sildHbpJvjvXPLuaoVEahfOEtplk1kggAFojJ
FqxFTtXMmiF6Nh98Jj75vSdoi7P3XInULSYj82SuImOOa3EozwFPooWh1tHlRL8=
=eQc9
-----END PGP SIGNATURE-----

--liOOAslEiF7prFVr--

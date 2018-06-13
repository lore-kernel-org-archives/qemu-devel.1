Received: from eggs.gnu.org ([2001:4830:134:3::10]:49532)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fT6tG-0005l6-6K
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 10:36:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fT6tC-0004jh-QK
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 10:36:50 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57908 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1fT6tC-0004i4-Kv
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 10:36:46 -0400
Date: Wed, 13 Jun 2018 15:36:42 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180613143642.GX24528@stefanha-x1.localdomain>
References: <20180609163252.27506-1-stefanha@redhat.com>
	<6d70ea23.116b3.163e77016fb.Coremail.suhang16@mails.ucas.ac.cn>
	<20180611135507.GF17756@stefanha-x1.localdomain>
	<36e0277e.1c637.163f28815e3.Coremail.suhang16@mails.ucas.ac.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZcaUvQ23gCOmDTXi"
Content-Disposition: inline
In-Reply-To: <36e0277e.1c637.163f28815e3.Coremail.suhang16@mails.ucas.ac.cn>
Subject: Re: [Qemu-devel] [PATCH] loader: implement START_SEG_ADDR_RECORD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Su Hang <suhang16@mails.ucas.ac.cn>
Cc: qemu-devel@nongnu.org, jusual@mail.ru, jim@groklearning.com, joel@jms.id.au, qemu.ml@steffen-goertz.de


--ZcaUvQ23gCOmDTXi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 12, 2018 at 01:46:34PM +0800, Su Hang wrote:
>=20
> I do have time, the function mentioned in last comments isn't difficult to
> implement, but I wonder how to write corresponding qtest-case for cortex-=
m3. You
> know, becuase #current# QEMU doesn't surpport the cortex-m3 instruction, =
I don't
> know how to prove correctness of hex loader. For example, in my past patch
> serias, "Hello World!" will be printed out, if Hex File get successfully =
loaded.
>=20
> Julia has told me a method, I haven't tried it. I will do it as quick as I
> could.

Thank you!

Stefan

--ZcaUvQ23gCOmDTXi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbISv6AAoJEJykq7OBq3PIxrgH/iWFjG54ueIxG2AOId8Swn5w
+0SryhO9N2csm1aKMtPq4ZFTPbjBcpgMSZz0y7H0GNlU3jXIbGNBa74rpL1gSzKM
E3qr5V11a9bSzWw8urVqzlU6JyHfJuyHqbMAaGor2fdSXKm63/EhOF2mOimsYPff
bcVEO930I9MgpFyPZb2aGYFWchQKNVZaQmaZV+jFtqfEO63BID9KhMY724wlY4Pr
6R6KIyU36mSLqgVLftfTnCObVyWI5XvMtvcni0QRRa/uGf2eXC++ulOLxXCJbF1C
ONW4MMon9nVHv8zqTcZ630MClVXXGVnuuzf6UvEh+Fese3rxSH1hq1pStyBEXIw=
=doPG
-----END PGP SIGNATURE-----

--ZcaUvQ23gCOmDTXi--

Received: from eggs.gnu.org ([2001:4830:134:3::10]:44830)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <psusi@ubuntu.com>) id 1fqe7S-000420-4f
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 08:44:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <psusi@ubuntu.com>) id 1fqe7O-0001lc-Od
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 08:44:46 -0400
Received: from ec2-34-202-238-73.compute-1.amazonaws.com
	([34.202.238.73]:47142 helo=vps.thesusis.net)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <psusi@ubuntu.com>) id 1fqe7O-0001jv-FZ
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 08:44:42 -0400
References: <bf97cfed-ca7f-8670-0aad-da1b847eb609@ubuntu.com>
	<20180816172722.GK23515@redhat.com>
	<83320617-5d60-fe71-3ef5-8ac7c384a3b1@ubuntu.com>
	<20180817085656.GA11124@redhat.com>
From: Phillip Susi <psusi@ubuntu.com>
Message-ID: <a115c4d1-0a78-efa1-0364-f41a06aca124@ubuntu.com>
Date: Fri, 17 Aug 2018 08:44:36 -0400
MIME-Version: 1.0
In-Reply-To: <20180817085656.GA11124@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ul410uJvmfhv2uKirai9veK7spWCzLNs2"
Subject: Re: [Qemu-devel] Pipe key broken on US keyboards
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ul410uJvmfhv2uKirai9veK7spWCzLNs2
From: Phillip Susi <psusi@ubuntu.com>
To: =?UTF-8?Q?Daniel_P._Berrang=c3=a9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org
Message-ID: <a115c4d1-0a78-efa1-0364-f41a06aca124@ubuntu.com>
Subject: Re: Pipe key broken on US keyboards
References: <bf97cfed-ca7f-8670-0aad-da1b847eb609@ubuntu.com>
 <20180816172722.GK23515@redhat.com>
 <83320617-5d60-fe71-3ef5-8ac7c384a3b1@ubuntu.com>
 <20180817085656.GA11124@redhat.com>
In-Reply-To: <20180817085656.GA11124@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 8/17/2018 4:56 AM, Daniel P. Berrang=C3=A9 wrote:
> Oh one other thing, is whether your QEMU process has an explicit keymap=

> configured (this is the -k arg to QEMU), as when that it set, it
> completely changes the way keyboard input is handled in VNC. That code
> has also been massively refactored recently.

I'm not using that argument.  I just checked the man page and it says it
defaults to en-us, which should be correct.



--ul410uJvmfhv2uKirai9veK7spWCzLNs2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJbdsM4AAoJENsuw7lhAP6EAUEH/2lnx4bx8o6loN+9xFMmNtUV
/Qxc7mzXZlM8agWQpKwFL7Q/23fgWnM3YlX6QdYMCtwv5euC7X4OnX9uccq89xEn
PVEX/PZS5uyYZOn1EScjxka5VCT8SB1M+7n5XZwcTR5MdIMP34RWVKsV5wvp1HT/
kI375uCf7CdKmGGxM3OyPsYWHQmQNC8ax/YzggxaFKcvdpy6Ucl4sojZWbuh2uUY
UA2+jeZP92rOFCnfazYN6x8mstaak6JOdKkSukIjy9dkZYXxk978sRwigm5ORnBn
yPQvFQIf0gmKOHTFIiQPefZrPakDQO3JYzHIdXfHYb1up/sAh6dd59FUhhp3K8c=
=Xpw7
-----END PGP SIGNATURE-----

--ul410uJvmfhv2uKirai9veK7spWCzLNs2--

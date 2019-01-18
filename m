Received: from eggs.gnu.org ([209.51.188.92]:44159)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gkR1x-0007lr-Mn
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 05:05:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gkR1w-00028T-VB
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 05:05:41 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332]:52921)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1gkR1v-00023e-Hb
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 05:05:40 -0500
Received: by mail-wm1-x332.google.com with SMTP id m1so3918745wml.2
	for <qemu-devel@nongnu.org>; Fri, 18 Jan 2019 02:05:38 -0800 (PST)
Date: Fri, 18 Jan 2019 10:05:35 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20190118100535.GC21579@stefanha-x1.localdomain>
References: <20190117145207.31212-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Izn7cH1Com+I3R9J"
Content-Disposition: inline
In-Reply-To: <20190117145207.31212-1-berrange@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] trace: add ability to do simple printf
 logging via systemtap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>


--Izn7cH1Com+I3R9J
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 17, 2019 at 02:52:07PM +0000, Daniel P. Berrang=E9 wrote:

Nice improvement, thanks!  Do you want to send a docs/devel/tracing.txt
follow-up patch to document this feature?

Thanks, applied to my tracing tree:
https://github.com/stefanha/qemu/commits/tracing

Stefan

--Izn7cH1Com+I3R9J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcQaTvAAoJEJykq7OBq3PIAYUIAL4vygBB/R/yAyeVxhLWpR3l
+4haCNMTUKDgAM5zftMFfjNXSW7QdWrU8kRta6RZ8G4b92iM35/XEj7RrhLyaH8K
L1dzbPBKbWjZGLBDDa4gTOy/IYzZ8wsfS3MJQAEKIeo/+c4Sd4Ylg79YwTe87s+W
4qp742sEspy+G5IJowH6DeO+onJrDlhi9Uw03KVsiw1vVt+uiMJuGSKW9kM5ibLc
Uha6PqAkSy0TEQ+tyuz28x0B6HNryALlXzs22+PEBY7LdDpSnFo3ND1c0PrXhVfY
Ea2qEnPU6qaJisA4XQN/8vPayV/kWWY0fg0X8MWAiVSfQ4frqLHjSe6TDvsbva4=
=ICX9
-----END PGP SIGNATURE-----

--Izn7cH1Com+I3R9J--

Received: from eggs.gnu.org ([2001:4830:134:3::10]:33783)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dnPp8-0000jL-TH
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 09:47:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dnPp4-0003ba-BY
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 09:47:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40766)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dnPp4-0003bO-4q
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 09:47:54 -0400
References: <20170831082210.8362-1-stefanha@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <60e1d24c-0e8c-42a1-c625-051b2dc0375a@redhat.com>
Date: Thu, 31 Aug 2017 08:47:49 -0500
MIME-Version: 1.0
In-Reply-To: <20170831082210.8362-1-stefanha@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="tsWlX5q6Ha9B41DIRMwR84tPofIcdMKwj"
Subject: Re: [Qemu-devel] [PULL for-2.10 00/15] Block patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--tsWlX5q6Ha9B41DIRMwR84tPofIcdMKwj
From: Eric Blake <eblake@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <60e1d24c-0e8c-42a1-c625-051b2dc0375a@redhat.com>
Subject: Re: [Qemu-devel] [PULL for-2.10 00/15] Block patches
References: <20170831082210.8362-1-stefanha@redhat.com>
In-Reply-To: <20170831082210.8362-1-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/31/2017 03:21 AM, Stefan Hajnoczi wrote:
> The following changes since commit 248b23735645f7cbb503d9be6f5bf825f2a6=
03ab:

Subject line should probably say 2.11, not 2.10 :)

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--tsWlX5q6Ha9B41DIRMwR84tPofIcdMKwj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmoE4UACgkQp6FrSiUn
Q2rhIAf/W3wmtF7hoxolmiF7nGtLbT+0rnDoP6btTPpjyM+14q3+kcfR1L7O38cE
dG5dSJ8AUZqxkmy525YFu2Vim6hnEyREzvLdxsWAsriOdBjmVcZ1e+Vh0REX9m4f
t9lwj89jUqRoBlQuZmsrkkfmUqjiqGwAfmdv6QZUCiTPgHUXpCOKFTcC8P3NlFA2
wdkPONkP1X1XELmic+Pbrua2++w7hahrXZGF4KkdAecLHBX1rLj+OwTgwb6faM1b
lEdhVvrZYF9RFJVZLCO9RZ6snTdQFiCVbHyNuF2CbCn84bmaCEimuYdFJDY+gWYQ
P/H2g+aaZx9Q2nvAZKu6zS7A8BbEnA==
=aMqK
-----END PGP SIGNATURE-----

--tsWlX5q6Ha9B41DIRMwR84tPofIcdMKwj--

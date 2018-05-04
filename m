Received: from eggs.gnu.org ([2001:4830:134:3::10]:38903)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <olaf@aepfle.de>) id 1fEgZ5-0000vP-BV
	for qemu-devel@nongnu.org; Fri, 04 May 2018 15:40:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <olaf@aepfle.de>) id 1fEgZ4-0003bH-KG
	for qemu-devel@nongnu.org; Fri, 04 May 2018 15:40:23 -0400
Received: from mo6-p01-ob.smtp.rzone.de ([2a01:238:20a:202:5301::5]:18952)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <olaf@aepfle.de>) id 1fEgZ4-0003Xy-0M
	for qemu-devel@nongnu.org; Fri, 04 May 2018 15:40:22 -0400
Date: Fri, 4 May 2018 21:40:06 +0200
From: Olaf Hering <olaf@aepfle.de>
Message-ID: <20180504214006.17217d00.olaf@aepfle.de>
In-Reply-To: <20180504160026.14017-1-berrange@redhat.com>
References: <20180504160026.14017-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/xJTTqV05620li4Afw1xeRmr";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH 0/3] Document intent for supported build
 platforms and bump min glib to 2.42
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Eric Blake <eblake@redhat.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>

--Sig_/xJTTqV05620li4Afw1xeRmr
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Am Fri,  4 May 2018 17:00:23 +0100
schrieb Daniel P. Berrang=C3=A9 <berrange@redhat.com>:

>   - I suggested following libvirt's lead in writing a policy for how
>     we pick supported OS targets to inform maintainers when min versions
>     can be increased.

Since Xen depends on qemu, it also means that SLE11 will disappear silently=
 for them.

Olaf

--Sig_/xJTTqV05620li4Afw1xeRmr
Content-Type: application/pgp-signature
Content-Description: Digitale Signatur von OpenPGP

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQSkRyP6Rn//f03pRUBdQqD6ppg2fgUCWuy3FgAKCRBdQqD6ppg2
fn04AJ9CQXAbu89PLmBDf/Pc7ssOlEWZSACff8j1fuT4yp57W+VB9EZhfwWe5Uc=
=dpbC
-----END PGP SIGNATURE-----

--Sig_/xJTTqV05620li4Afw1xeRmr--

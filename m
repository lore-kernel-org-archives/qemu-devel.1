Received: from eggs.gnu.org ([2001:4830:134:3::10]:51822)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cH8kR-0004Nt-Q5
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 07:33:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cH8kM-00087l-8C
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 07:33:27 -0500
Received: from mail-qk0-f193.google.com ([209.85.220.193]:33242)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cH8kM-00087V-3a
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 07:33:22 -0500
Received: by mail-qk0-f193.google.com with SMTP id x190so2544065qkb.0
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 04:33:21 -0800 (PST)
Date: Wed, 14 Dec 2016 12:32:19 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20161214123219.GA2643@stefanha-x1.localdomain>
References: <20161213214917.6436-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IJpNTDwzlM2Ie8A6"
Content-Disposition: inline
In-Reply-To: <20161213214917.6436-1-stefanha@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] Update language files for QEMU 2.8.0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Weil <sw@weilnetz.de>


--IJpNTDwzlM2Ie8A6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 13, 2016 at 09:49:17PM +0000, Stefan Hajnoczi wrote:
> Update translation files (change created via 'make -C po update').
>=20
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  po/bg.po       | 40 ++++++++++++++++++++--------------------
>  po/de_DE.po    | 40 ++++++++++++++++++++++------------------
>  po/fr_FR.po    | 40 ++++++++++++++++++++++------------------
>  po/hu.po       | 40 ++++++++++++++++++++++------------------
>  po/it.po       | 40 ++++++++++++++++++++++------------------
>  po/messages.po | 42 +++++++++++++++++++++++-------------------
>  po/tr.po       | 40 ++++++++++++++++++++++------------------
>  po/zh_CN.po    | 40 ++++++++++++++++++++++------------------
>  8 files changed, 175 insertions(+), 147 deletions(-)

Thanks, applied to my staging tree:
https://github.com/stefanha/qemu/commits/staging

Stefan

--IJpNTDwzlM2Ie8A6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYUTvSAAoJEJykq7OBq3PIWQ8H/2gOAHHB6Ksv0xRgskkWuARj
HOamS3NdBLYNeuzgtST3XVDJmwvZ/ubFplTjvI+tvtxONDaSl9K0J/vgiOJrQtJp
BydFidC4LCe2Ta/j7E/9kI59Kz576Nf5/QwuJCb89LbxXgM0IMsKCeVegy4aWshC
+1SR7ppTeAwG1dojFhuRJ9KaE7dEGdSivY3GHWpdI+2csVVTU4qi/t7ynmbuywk6
ly+VTeJta1/zeyqXKbTuBxuAqu17P3KZu+zyGuWbjAFz4O4cZQ4MEPnE7Lbwn6WW
ZdHWj82DMfb9eEmqE76EyHOZZG8PDVaf4FuBxZvxDusZYUmGVctinPiwYL954zM=
=OH6D
-----END PGP SIGNATURE-----

--IJpNTDwzlM2Ie8A6--

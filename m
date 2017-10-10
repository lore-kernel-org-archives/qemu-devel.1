Received: from eggs.gnu.org ([2001:4830:134:3::10]:56817)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e1yZS-000052-B0
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 13:43:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e1yZP-0005bu-1Y
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 13:43:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49250)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1e1yZO-0005bZ-SU
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 13:43:54 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E66ABC04B303
	for <qemu-devel@nongnu.org>; Tue, 10 Oct 2017 17:43:53 +0000 (UTC)
References: <20171010154328.8419-1-berrange@redhat.com>
	<20171010154328.8419-8-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <2503f9aa-cd1a-cc1e-deb7-175a50e319b6@redhat.com>
Date: Tue, 10 Oct 2017 12:43:52 -0500
MIME-Version: 1.0
In-Reply-To: <20171010154328.8419-8-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="p9HnXmdBb36sVbLBA3lpMBFXF4w0f45Iv"
Subject: Re: [Qemu-devel] [PATCH v1 7/7] io: add trace points for websocket
 HTTP protocol headers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--p9HnXmdBb36sVbLBA3lpMBFXF4w0f45Iv
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Message-ID: <2503f9aa-cd1a-cc1e-deb7-175a50e319b6@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v1 7/7] io: add trace points for websocket
 HTTP protocol headers
References: <20171010154328.8419-1-berrange@redhat.com>
 <20171010154328.8419-8-berrange@redhat.com>
In-Reply-To: <20171010154328.8419-8-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/10/2017 10:43 AM, Daniel P. Berrange wrote:
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  io/channel-websock.c | 4 ++++
>  io/trace-events      | 2 ++
>  2 files changed, 6 insertions(+)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--p9HnXmdBb36sVbLBA3lpMBFXF4w0f45Iv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlndBtgACgkQp6FrSiUn
Q2rhEAf/QgYOC3rd7gkJOcifeaoDFAMrqjbfpGfvWnvnZ2MqAioweMDl1aSYs1gU
jQUb/p/y7Q4Enik+PZ7/sTahLPYujMnn2nG1/eDefDhNqo+45Y/Wx1Ulfuc2VtCK
C7sHiinjlnRRiIipf9hqKRbCn5B4Bt5K5RyHGTqjWjwqCw6DLfnUrZs02kEQ21X2
AOAn7qmFcCu2KLevmqCAgRvAOCBuPeYNdj/m+IDxeuckoTDscGixn8u54+jQn61z
nek44JIxPn6VwjIfO8izDwcBWNOLTv13JVxIT4//WppEMNIXByhO4LuE1Xt7BePi
E+3r55OAWLvnyf4o4lRs4ILh01T9sw==
=sKDh
-----END PGP SIGNATURE-----

--p9HnXmdBb36sVbLBA3lpMBFXF4w0f45Iv--

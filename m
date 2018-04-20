Received: from eggs.gnu.org ([2001:4830:134:3::10]:34984)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1f9Vzg-0000PG-8J
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 09:22:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1f9Vzf-0000Qf-GC
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 09:22:28 -0400
References: <20180416165849.28864-1-mreitz@redhat.com>
	<20180416165849.28864-10-mreitz@redhat.com>
	<20180420084330.GR15181@stefanha-x1.localdomain>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <2462ab9a-b53f-16e8-e6ab-8172bea401f6@redhat.com>
Date: Fri, 20 Apr 2018 15:22:15 +0200
MIME-Version: 1.0
In-Reply-To: <20180420084330.GR15181@stefanha-x1.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="vkwlVMjOQCmRRBaSwr4OECsPjx8VMHOxq"
Subject: Re: [Qemu-devel] [PATCH 9/9] iotests: Add test for COR across nodes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--vkwlVMjOQCmRRBaSwr4OECsPjx8VMHOxq
From: Max Reitz <mreitz@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <2462ab9a-b53f-16e8-e6ab-8172bea401f6@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 9/9] iotests: Add test for COR across nodes
References: <20180416165849.28864-1-mreitz@redhat.com>
 <20180416165849.28864-10-mreitz@redhat.com>
 <20180420084330.GR15181@stefanha-x1.localdomain>
In-Reply-To: <20180420084330.GR15181@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 2018-04-20 10:43, Stefan Hajnoczi wrote:
> On Mon, Apr 16, 2018 at 06:58:49PM +0200, Max Reitz wrote:
>> diff --git a/tests/qemu-iotests/216 b/tests/qemu-iotests/216
>> new file mode 100755
>> index 0000000000..2f34f94faa
>> --- /dev/null
>> +++ b/tests/qemu-iotests/216
>> @@ -0,0 +1,117 @@
>> +#!/usr/bin/env python
>=20
> Welcome to the dark side!

:-)

> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>



--vkwlVMjOQCmRRBaSwr4OECsPjx8VMHOxq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlrZ6YcACgkQ9AfbAGHV
z0DKKgf+J9JnHk7O3tSvBMy3FWWBaa3PjT/KnJATEqM0Cjmq+cPEEk03yLux9BuT
0MSQXMThYsN5kf8XOSL4uJzIkK66tXpKSi8Rr5fXB/AZfaaSnJVygh4K4CCJKxWo
g7aKGMVDg6xYyVhLQ47r1frG8EJgSDrynkgZLOMG7ItMnWrGZ9xt3jPcelvbsVGi
ldp88py7wVu5IicYJmjvqzWh1BFwGHd8kDsMUtqRzybXUFCYR6UO2MFdxlIsIC0T
+tf6pF9RRMi/98FsAQNo12nzh9SSJqe6XNGB9RNbBMGBUiQI4Q2Y3anW0AmR2pVM
gg8MllQLdXDbYKnZ/OH0azbFNi55HA==
=lKvk
-----END PGP SIGNATURE-----

--vkwlVMjOQCmRRBaSwr4OECsPjx8VMHOxq--

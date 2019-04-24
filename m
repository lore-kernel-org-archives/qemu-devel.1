Received: from eggs.gnu.org ([209.51.188.92]:33946)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hJIM2-0008ST-PW
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 09:54:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hJIGq-0002ib-JW
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 09:49:09 -0400
References: <20180713111424.23670-1-mreitz@redhat.com>
	<9afddacb-ca54-6ac3-1c02-b8916a08fcd3@redhat.com>
	<c3f01ebe-37f7-d1d8-8bcd-45df37d80ff6@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <3583e4e9-d29e-fc5a-6e83-637e515c38f7@redhat.com>
Date: Wed, 24 Apr 2019 15:48:55 +0200
MIME-Version: 1.0
In-Reply-To: <c3f01ebe-37f7-d1d8-8bcd-45df37d80ff6@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="WbTQsdO1hO6b1aqFXzRpYXmiowF2oosH9"
Subject: Re: [Qemu-devel] [PATCH 0/3] qemu-img: Allow rebase with no input
 base
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: Kevin Wolf <kwolf@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--WbTQsdO1hO6b1aqFXzRpYXmiowF2oosH9
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: Kevin Wolf <kwolf@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Message-ID: <3583e4e9-d29e-fc5a-6e83-637e515c38f7@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/3] qemu-img: Allow rebase with no input
 base
References: <20180713111424.23670-1-mreitz@redhat.com>
 <9afddacb-ca54-6ac3-1c02-b8916a08fcd3@redhat.com>
 <c3f01ebe-37f7-d1d8-8bcd-45df37d80ff6@virtuozzo.com>
In-Reply-To: <c3f01ebe-37f7-d1d8-8bcd-45df37d80ff6@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 18.04.19 19:00, Vladimir Sementsov-Ogievskiy wrote:
> 13.04.2019 19:11, Max Reitz wrote:
>> Ping again
>>
>> (I feel like I just need to start merging unreviewed patches until I
>> break something (can't take that long) so you get so scared of my
>> patches that you at least refuse them outright)
>=20
> Could you resend before?

Sure, but for me, this series still applies as-is.

Max


--WbTQsdO1hO6b1aqFXzRpYXmiowF2oosH9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlzAaUcACgkQ9AfbAGHV
z0CdwQf9F8Il0sXGQuaThI7ulHJJUDNq/aRhuVZLF0GF1xjKZ9/98L7Cgg/Otpol
a5BjHLz1ENixS2big3uRjY+Ch1sx1qibkH20jP9T3OAYHsnZz03DDP5DM3qvR4jV
sSbHonLi2Swpr4Mv9FdseCAUJ7BtqPUqv+rXMHQiBGqkADhgaPCluX3VkQ3A9G81
iQtSp4Uhn+aGMtMw7vRJeNOSaFYk67A5VKX48hn7UlQpHValKnf9t8RhMqMx7EOT
RGGh8izy2HL2o3DrOuOfyE9HHWRxkaLGw1S8sVaGReYfwNWkjOEi3DTjk5yPcFN4
CQVe9G2BzVXvGF5N+XCnz7E3q+1gZQ==
=Z+z0
-----END PGP SIGNATURE-----

--WbTQsdO1hO6b1aqFXzRpYXmiowF2oosH9--

Received: from eggs.gnu.org ([2001:4830:134:3::10]:60597)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fO05C-0003ok-UC
	for qemu-devel@nongnu.org; Wed, 30 May 2018 08:20:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fO058-0003yx-Pu
	for qemu-devel@nongnu.org; Wed, 30 May 2018 08:20:02 -0400
References: <20180426161958.2872-1-rkagan@virtuozzo.com>
	<20180426161958.2872-6-rkagan@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <f65c0b67-b628-4d30-8921-1311d369874d@redhat.com>
Date: Wed, 30 May 2018 14:19:54 +0200
MIME-Version: 1.0
In-Reply-To: <20180426161958.2872-6-rkagan@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="sZ2TUy12cXqGiZIMLDuZop8w70mUqMk1k"
Subject: Re: [Qemu-devel] [PATCH 05/17] iotest 030: require blkdebug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Roman Kagan <rkagan@virtuozzo.com>, Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--sZ2TUy12cXqGiZIMLDuZop8w70mUqMk1k
From: Max Reitz <mreitz@redhat.com>
To: Roman Kagan <rkagan@virtuozzo.com>, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Message-ID: <f65c0b67-b628-4d30-8921-1311d369874d@redhat.com>
Subject: Re: [PATCH 05/17] iotest 030: require blkdebug
References: <20180426161958.2872-1-rkagan@virtuozzo.com>
 <20180426161958.2872-6-rkagan@virtuozzo.com>
In-Reply-To: <20180426161958.2872-6-rkagan@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-04-26 18:19, Roman Kagan wrote:
> This test uses blkdebug extensively so notrun it if blkdebug is
> disabled in QEMU.
>=20
> Signed-off-by: Roman Kagan <rkagan@virtuozzo.com>
> ---
>  tests/qemu-iotests/030 | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--sZ2TUy12cXqGiZIMLDuZop8w70mUqMk1k
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlsOluoACgkQ9AfbAGHV
z0ACMAf/bjGTaDTxrPY7WEAnax5wb49Svdqm1uNSmrC3vW2b5oYa/uxGFTAg5x/+
b13ZW7Q4MUaFnckSIoCZWD0k+1lDpSJeOxKMyKHNyxE6xrUrzusB+J8d7Ykffxe8
ThRxkgt6YzutUEC2jK4jAW7N6pILnOQZET6rUQjxpizk4nmOoVvx8t9NLdhLaNEw
y3aWjP0tqIin3V0AVfxk6RNVTKvkiWVlA5Qxvo4ymcbUV06myb/dznn2UcpKag+k
HLpQX5ToMriw6YqPelAVpFfItIOvPsU1LyQ+T9Jk8oZv6iE7qwcaRFrfAcS2Wh3V
fiKrF2svhQB/8qNgbys1BbWfwoR3zA==
=y2x9
-----END PGP SIGNATURE-----

--sZ2TUy12cXqGiZIMLDuZop8w70mUqMk1k--

Received: from eggs.gnu.org ([209.51.188.92]:48382)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gu6uh-0004Ss-4X
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 21:38:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gu6ug-0003LX-Gu
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 21:38:11 -0500
References: <20181203175211.8230-1-mreitz@redhat.com>
	<20181203175211.8230-6-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a3cdab69-bf99-6228-dfa8-ee5dc759afc3@redhat.com>
Date: Wed, 13 Feb 2019 20:38:01 -0600
MIME-Version: 1.0
In-Reply-To: <20181203175211.8230-6-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="I00MsLs9UIUWcHbhZMSscqEFj3YdiOJ4y"
Subject: Re: [Qemu-devel] [PATCH for-next 5/6] blkdebug: Inject errors on
 .bdrv_co_block_status()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--I00MsLs9UIUWcHbhZMSscqEFj3YdiOJ4y
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Message-ID: <a3cdab69-bf99-6228-dfa8-ee5dc759afc3@redhat.com>
Subject: Re: [PATCH for-next 5/6] blkdebug: Inject errors on
 .bdrv_co_block_status()
References: <20181203175211.8230-1-mreitz@redhat.com>
 <20181203175211.8230-6-mreitz@redhat.com>
In-Reply-To: <20181203175211.8230-6-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/3/18 11:52 AM, Max Reitz wrote:
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  qapi/block-core.json | 5 ++++-
>  block/blkdebug.c     | 8 ++++++++
>  2 files changed, 12 insertions(+), 1 deletion(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--I00MsLs9UIUWcHbhZMSscqEFj3YdiOJ4y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxk1IkACgkQp6FrSiUn
Q2q9iAf+Lrle9xjK0XUMzkkFkcY80fzhMh2sWriH1HN6m7zJkSC4oZDwTvqlhvkh
Bo+qsFeg+WNu0cKx9Yv3oyAy01SPyXDNemceZt4RZBf7kJHvP5HWEEvG1GCzghIn
4/H9ejHB+mQOGh+51FpQDQ5TBVNXe1W3PPeF3J5THBqacRuGfmfyWdXE9SdDbWHp
00pbaw2sYcjDqyd4CNcdJRYip5no0Cm9Mx9FT33ynzAQAmmGZcp4hgjc3OstVEdn
9zjNjMKCUS41zS6Pmw3FaJEeRxQ223JOZY/LxQw05c/etPPZ69++q/FUrxr/e/z0
mH51sxCOkPRaG984cKAevf6jlqBGtA==
=xW1j
-----END PGP SIGNATURE-----

--I00MsLs9UIUWcHbhZMSscqEFj3YdiOJ4y--

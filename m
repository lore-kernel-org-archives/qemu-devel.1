Received: from eggs.gnu.org ([209.51.188.92]:57483)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gj3Ly-00025B-Pl
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 09:36:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gj3Lw-0007F1-MC
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 09:36:38 -0500
References: <20181229122027.42245-1-vsementsov@virtuozzo.com>
	<20181229122027.42245-5-vsementsov@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <6199ffae-1a9f-e750-029c-70e97dfe246a@redhat.com>
Date: Mon, 14 Jan 2019 15:36:01 +0100
MIME-Version: 1.0
In-Reply-To: <20181229122027.42245-5-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="nigvTius189ZWFcmQq2KJ6ZKLGEVvfove"
Subject: Re: [Qemu-devel] [PATCH v5 04/11] iotests: handle -f argument
 correctly for qemu_io_silent
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: fam@euphon.net, stefanha@redhat.com, jcody@redhat.com, kwolf@redhat.com, den@openvz.org, eblake@redhat.com, jsnow@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--nigvTius189ZWFcmQq2KJ6ZKLGEVvfove
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: fam@euphon.net, stefanha@redhat.com, jcody@redhat.com, kwolf@redhat.com,
 den@openvz.org, eblake@redhat.com, jsnow@redhat.com
Message-ID: <6199ffae-1a9f-e750-029c-70e97dfe246a@redhat.com>
Subject: Re: [PATCH v5 04/11] iotests: handle -f argument correctly for
 qemu_io_silent
References: <20181229122027.42245-1-vsementsov@virtuozzo.com>
 <20181229122027.42245-5-vsementsov@virtuozzo.com>
In-Reply-To: <20181229122027.42245-5-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 29.12.18 13:20, Vladimir Sementsov-Ogievskiy wrote:
> Correctly rewrite default argument. After the patch, the function can
> be used for other (not only default test-chosen) image format.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  tests/qemu-iotests/iotests.py | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--nigvTius189ZWFcmQq2KJ6ZKLGEVvfove
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlw8nlEACgkQ9AfbAGHV
z0CbBwf/QJ483gCsBw9F477JkoXQ0GRlvEoJz2gpPZixWzHCemLzTA9vXTHXlWD0
WHCCcaJ7SULYf2jnJdjtwc3W4exPF0L6QxE0iGmioCJSU7idKKAj1ccqxC+9dPaz
Qfg73UvGRMR6Xb6vY872bhr7MF1HWc+8ddy1jhLDUarHlbkhbSV0SxOPgKdS4DJb
rNo1lY2237xQk1ZvscDFJcrnfQW7CyWGReLhP6t2bTRQKN7+9uGQlxaYTlN3UsMT
huTyRN6CtXBHwtcaK56Jr1eeQuuCUYPppr9+sZncHHBzGI5ALF+Mt+peBO6XBn6k
Rcc+fpB4khjumis5cFF/Zcsuw6RuLg==
=fpds
-----END PGP SIGNATURE-----

--nigvTius189ZWFcmQq2KJ6ZKLGEVvfove--

Received: from eggs.gnu.org ([2001:4830:134:3::10]:58230)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dUzYW-00077O-LH
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 14:06:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dUzYV-0002No-PD
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 14:06:40 -0400
References: <20170711124024.1396-1-pbutsykin@virtuozzo.com>
	<20170711124024.1396-5-pbutsykin@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <8b304364-9b68-dc93-c1f0-7920f14fbabb@redhat.com>
Date: Tue, 11 Jul 2017 20:06:30 +0200
MIME-Version: 1.0
In-Reply-To: <20170711124024.1396-5-pbutsykin@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="srhAEsbIV4Wuc91SjJMKvroWKCBjfvvTB"
Subject: Re: [Qemu-devel] [PATCH v4 4/4] qemu-iotests: add shrinking image
 test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Butsykin <pbutsykin@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, eblake@redhat.com, armbru@redhat.com, den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--srhAEsbIV4Wuc91SjJMKvroWKCBjfvvTB
From: Max Reitz <mreitz@redhat.com>
To: Pavel Butsykin <pbutsykin@virtuozzo.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Cc: kwolf@redhat.com, eblake@redhat.com, armbru@redhat.com, den@openvz.org
Message-ID: <8b304364-9b68-dc93-c1f0-7920f14fbabb@redhat.com>
Subject: Re: [PATCH v4 4/4] qemu-iotests: add shrinking image test
References: <20170711124024.1396-1-pbutsykin@virtuozzo.com>
 <20170711124024.1396-5-pbutsykin@virtuozzo.com>
In-Reply-To: <20170711124024.1396-5-pbutsykin@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-07-11 14:40, Pavel Butsykin wrote:
> Signed-off-by: Pavel Butsykin <pbutsykin@virtuozzo.com>
> ---
>  tests/qemu-iotests/163     | 170 +++++++++++++++++++++++++++++++++++++=
++++++++
>  tests/qemu-iotests/163.out |   5 ++
>  tests/qemu-iotests/group   |   1 +
>  3 files changed, 176 insertions(+)
>  create mode 100644 tests/qemu-iotests/163
>  create mode 100644 tests/qemu-iotests/163.out

Reviewed-by: Max Reitz <mreitz@redhat.com>


--srhAEsbIV4Wuc91SjJMKvroWKCBjfvvTB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEvBAEBCAAZBQJZZROmEhxtcmVpdHpAcmVkaGF0LmNvbQAKCRD0B9sAYdXPQIPU
B/9KSEnBt6LuUcHtkkSb0yr4wMyfxoYPrXry4fTZAcOPOf4nOLlOdvEjgF0ojDUC
kO6+EULpkDbCfCybZWa4+CTPRQwDmZ9/Y5RLe3w/rFCC6huc3+pTBbursOvZ++8+
yJSaV81+AyUet+FaHyDSqZ63K2OV5JzQQIeYfXLxqWgJFgl1WgJBGMoAncAqlTfw
gDmhVoxgQbiLayo3I/5wcr/KwzYxo85PlwsgM/jOxOKC89YbqibylDhMWMeDQrpY
zJ7YMpZqThFIGtCssYEPPhhOA6n3bXyTiKWe+jfYXC3SFgSqJhGY4bEeNPdjv5jB
BjuOgTObadFHvImGH5GCSwdh
=1ZBE
-----END PGP SIGNATURE-----

--srhAEsbIV4Wuc91SjJMKvroWKCBjfvvTB--

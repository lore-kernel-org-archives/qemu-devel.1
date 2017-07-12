Received: from eggs.gnu.org ([2001:4830:134:3::10]:42793)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dVKPI-0003C0-MW
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 12:22:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dVKPH-0004vB-Mz
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 12:22:32 -0400
References: <1499864249-26305-1-git-send-email-kwolf@redhat.com>
	<1499864249-26305-9-git-send-email-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <cdea6fd7-a0f5-d496-54c2-c2c5b04b6dc9@redhat.com>
Date: Wed, 12 Jul 2017 11:22:19 -0500
MIME-Version: 1.0
In-Reply-To: <1499864249-26305-9-git-send-email-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="cnVtoWIA8XrffslheRB9ql5kqJCEmTkSc"
Subject: Re: [Qemu-devel] [PATCH 8/9] qemu-iotests: Test 'info block'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: mreitz@redhat.com, jsnow@redhat.com, pbonzini@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--cnVtoWIA8XrffslheRB9ql5kqJCEmTkSc
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: mreitz@redhat.com, jsnow@redhat.com, pbonzini@redhat.com,
 armbru@redhat.com, qemu-devel@nongnu.org
Message-ID: <cdea6fd7-a0f5-d496-54c2-c2c5b04b6dc9@redhat.com>
Subject: Re: [PATCH 8/9] qemu-iotests: Test 'info block'
References: <1499864249-26305-1-git-send-email-kwolf@redhat.com>
 <1499864249-26305-9-git-send-email-kwolf@redhat.com>
In-Reply-To: <1499864249-26305-9-git-send-email-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/12/2017 07:57 AM, Kevin Wolf wrote:
> This test makes sure that all block devices show up on 'info block',
> with all of the expected information, in different configurations.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  tests/qemu-iotests/186     | 147 ++++++++++++++
>  tests/qemu-iotests/186.out | 489 +++++++++++++++++++++++++++++++++++++=
++++++++
>  tests/qemu-iotests/group   |   1 +
>  3 files changed, 637 insertions(+)
>  create mode 100755 tests/qemu-iotests/186
>  create mode 100644 tests/qemu-iotests/186.out
>=20
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--cnVtoWIA8XrffslheRB9ql5kqJCEmTkSc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZZky8AAoJEKeha0olJ0NqTsYH/2APDZEU9MfHrZITzGOn1VAg
AmfNGjW6gZW7lzRt4afdZc8An3VzdoXx7YnPC08379AyLMqKWk2+t2LRw5jsO4mN
m4x7VoHKSiK/nDMpYHaDOEM0vHLxTHShc5e7BSph02ZQqLSZx/NIO1w+7VqWAp4x
aXKdMxwj41mQ4iHmRbpozkxmnfVOMgoZCgmBPAt9wlM5Wggvn9sFsC4hc9s8ZTFX
ZLxkr8BM1u4N4voOYZaV/qIwlP2b6ypfz/fZYbaZC4BcPx9tP3efikLzDrcUacSn
55DGYZo85V54Yc6rK6TBMCPCdI6KQvjkUB69zjIfMXWmAGgqdsrYALRSAbSwyjg=
=BPq8
-----END PGP SIGNATURE-----

--cnVtoWIA8XrffslheRB9ql5kqJCEmTkSc--

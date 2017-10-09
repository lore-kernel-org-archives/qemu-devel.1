Received: from eggs.gnu.org ([2001:4830:134:3::10]:53688)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e1dcs-0006q2-5x
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 15:22:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e1dcr-0000M7-3U
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 15:22:06 -0400
References: <20171009172723.190282-1-vsementsov@virtuozzo.com>
	<20171009172723.190282-11-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c3bf5c86-a1aa-5330-ce46-223c57866136@redhat.com>
Date: Mon, 9 Oct 2017 14:21:55 -0500
MIME-Version: 1.0
In-Reply-To: <20171009172723.190282-11-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="2t8qbNhLMnBtmQRJaSAFBakIcCklehI58"
Subject: Re: [Qemu-devel] [PATCH v2 05/10] nbd: header constants indenting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2t8qbNhLMnBtmQRJaSAFBakIcCklehI58
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org
Message-ID: <c3bf5c86-a1aa-5330-ce46-223c57866136@redhat.com>
Subject: Re: [PATCH v2 05/10] nbd: header constants indenting
References: <20171009172723.190282-1-vsementsov@virtuozzo.com>
 <20171009172723.190282-11-vsementsov@virtuozzo.com>
In-Reply-To: <20171009172723.190282-11-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/09/2017 12:27 PM, Vladimir Sementsov-Ogievskiy wrote:
> Prepare indenting for the following commit.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  include/block/nbd.h | 15 ++++++++-------
>  nbd/nbd-internal.h  | 34 +++++++++++++++++-----------------
>  2 files changed, 25 insertions(+), 24 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--2t8qbNhLMnBtmQRJaSAFBakIcCklehI58
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnbzFMACgkQp6FrSiUn
Q2rk9gf5AQIsp7doOYp+uvN5MgQfRlDZaRuLNQz39D+RmsZbizKRo6vUFv3lsxUl
mHwPJPlBBwYxWPgD5+j/5cuVqr4mm+KRXHGnD/PFncysXASSIEAKQClxCrdV7Sr9
6O7+kCWDNPKADWXzYbi5Z11BeS7AO75b03rEHfvutieoPCgJMPJlS5TOzFJTsWMB
W/MuXmaecPykX5W1ZsesLU6GebDJj5hJuA9Nyr8KMMCIV+HP1f1m99pNvcUXUcOw
Gwqtz1Sm82vOE/wfETiCHf6ygk18O+WkA/CrkgpGpymypKBsjm6MEzCHafXGFKYH
gpwc7NlA0PEeFlO3vK+6b9nXfKg+dw==
=kuxZ
-----END PGP SIGNATURE-----

--2t8qbNhLMnBtmQRJaSAFBakIcCklehI58--

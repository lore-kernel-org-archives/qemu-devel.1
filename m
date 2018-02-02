Received: from eggs.gnu.org ([2001:4830:134:3::10]:39467)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ehjQF-0005Ny-2O
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 17:03:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ehjQA-0007DR-MY
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 17:03:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55830)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ehjQA-0007Cr-HV
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 17:02:58 -0500
References: <20180202130336.24719-1-armbru@redhat.com>
	<20180202130336.24719-11-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <101635b7-2004-8212-2706-d31b48276719@redhat.com>
Date: Fri, 2 Feb 2018 16:02:52 -0600
MIME-Version: 1.0
In-Reply-To: <20180202130336.24719-11-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="SdtWfsIEExGEhKF1bf7AbZ06cI7MdeZKv"
Subject: Re: [Qemu-devel] [PATCH RFC 10/21] qapi/common: Eliminate
 QAPISchema.exprs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--SdtWfsIEExGEhKF1bf7AbZ06cI7MdeZKv
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com
Message-ID: <101635b7-2004-8212-2706-d31b48276719@redhat.com>
Subject: Re: [PATCH RFC 10/21] qapi/common: Eliminate QAPISchema.exprs
References: <20180202130336.24719-1-armbru@redhat.com>
 <20180202130336.24719-11-armbru@redhat.com>
In-Reply-To: <20180202130336.24719-11-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/02/2018 07:03 AM, Markus Armbruster wrote:
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  scripts/qapi/common.py | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--SdtWfsIEExGEhKF1bf7AbZ06cI7MdeZKv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlp04AwACgkQp6FrSiUn
Q2rbcQf8CZ3zJbWkluPp4FLQtX1N1MMPk5Ncrb3gRyT4KJtNcSvEZpt9W3TFCqbO
wN3lmHSQgD6mfUKvQ4v/cudsoNV4AUcdL4x61rNfxMkrDLcVZWUHic4dFSwCRxnW
WUNl6A1ahEfaecDTA/sVTUORUhwuwrvsBAe2BI6UlpaBjXeQHp4Ab0U7UipdaQMJ
vYor8Ihiuc829i6NDJt10Q/SaBt/plqf6Cz0GldWSv4m+j5J+Slrd/NwmKB7P2WW
SVHUfh3pavqyCQVdE5zxW0aRRydpBO0/JaMVxM50A32S/Tk4k1tGenRK5yDUbvU9
t4AOg/IlKey9kCo1cLrJOwXStMZ5Mw==
=Ukjr
-----END PGP SIGNATURE-----

--SdtWfsIEExGEhKF1bf7AbZ06cI7MdeZKv--

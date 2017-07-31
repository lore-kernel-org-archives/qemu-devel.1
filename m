Received: from eggs.gnu.org ([2001:4830:134:3::10]:35097)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dcDE3-0000cb-WA
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 12:07:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dcDDz-0003tJ-Qs
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 12:07:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37542)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dcDDz-0003sn-Gy
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 12:07:19 -0400
References: <20170731160135.12101-1-vsementsov@virtuozzo.com>
	<20170731160135.12101-2-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b52f076c-b542-bde8-d412-8f6734b9dc37@redhat.com>
Date: Mon, 31 Jul 2017 11:07:12 -0500
MIME-Version: 1.0
In-Reply-To: <20170731160135.12101-2-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="gAsn94d6AArIO9m8FcMuPiOjGpo4I0UQr"
Subject: Re: [Qemu-devel] [PATCH v3 1/4] coding_style: add point about 0x in
 trace-events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mreitz@redhat.com, jsnow@redhat.com, den@openvz.org, stefanha@gmail.com, peter.maydell@linaro.org, berrange@redhat.com, cohuck@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--gAsn94d6AArIO9m8FcMuPiOjGpo4I0UQr
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mreitz@redhat.com, jsnow@redhat.com, den@openvz.org,
 stefanha@gmail.com, peter.maydell@linaro.org, berrange@redhat.com,
 cohuck@redhat.com
Message-ID: <b52f076c-b542-bde8-d412-8f6734b9dc37@redhat.com>
Subject: Re: [PATCH v3 1/4] coding_style: add point about 0x in trace-events
References: <20170731160135.12101-1-vsementsov@virtuozzo.com>
 <20170731160135.12101-2-vsementsov@virtuozzo.com>
In-Reply-To: <20170731160135.12101-2-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/31/2017 11:01 AM, Vladimir Sementsov-Ogievskiy wrote:
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  CODING_STYLE | 35 +++++++++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--gAsn94d6AArIO9m8FcMuPiOjGpo4I0UQr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAll/VbAACgkQp6FrSiUn
Q2rNAQgAgqCJ0vAG3r/KPwmv20Z1GTydVVyP0Dmt3Ju7zetf1zaVvgbFGcFfKaSX
7kC21mGeuTFC3FVq50t7nIMkJJUbm9gT9nogkE3t+0PXhs8XpInNfs2Jg+VEefQH
T0ciR0HX0qJ9f+DOB1sHagtk7c/PuNsrsTjCCOapTE9KTT8vLSBJ+kiRGtDf4lHB
+C/qlfnhX0+Bx4O3gqYbnrIGtLsbCqZFyoAcHrIJnNxKNlfAkFdOmwznB1nHCzP4
4ZLy+gForkA5rTIEyaMow3sTuwOjt0irwrvG3S14aIpubwpeHvJ6FbyOMUQJgr2H
FDHVucKPsDn5ivIJ5YQfol5tnIOwLQ==
=Mghf
-----END PGP SIGNATURE-----

--gAsn94d6AArIO9m8FcMuPiOjGpo4I0UQr--

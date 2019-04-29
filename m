Received: from eggs.gnu.org ([209.51.188.92]:34123)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hKuK0-0003Ec-Fa
	for qemu-devel@nongnu.org; Sun, 28 Apr 2019 20:39:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hKuJz-0005oC-E2
	for qemu-devel@nongnu.org; Sun, 28 Apr 2019 20:39:04 -0400
From: Max Reitz <mreitz@redhat.com>
References: <20190402153730.54145-1-vsementsov@virtuozzo.com>
	<2292e073-b32e-a2db-59d5-755ddcf31417@redhat.com>
Message-ID: <4b9a1a65-6107-ceec-8da8-acfe0d95a151@redhat.com>
Date: Mon, 29 Apr 2019 02:38:56 +0200
MIME-Version: 1.0
In-Reply-To: <2292e073-b32e-a2db-59d5-755ddcf31417@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Qsj9sux6gNz1BcXq7mdyuUd9HGDfgRGNz"
Subject: Re: [Qemu-devel] [PATCH v5 00/10] qcow2: encryption threads
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, berto@igalia.com, pbonzini@redhat.com, den@openvz.org, berrange@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Qsj9sux6gNz1BcXq7mdyuUd9HGDfgRGNz
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, berto@igalia.com, pbonzini@redhat.com, den@openvz.org,
 berrange@redhat.com
Message-ID: <4b9a1a65-6107-ceec-8da8-acfe0d95a151@redhat.com>
Subject: Re: [PATCH v5 00/10] qcow2: encryption threads
References: <20190402153730.54145-1-vsementsov@virtuozzo.com>
 <2292e073-b32e-a2db-59d5-755ddcf31417@redhat.com>
In-Reply-To: <2292e073-b32e-a2db-59d5-755ddcf31417@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 29.04.19 02:37, Max Reitz wrote:
> On 02.04.19 17:37, Vladimir Sementsov-Ogievskiy wrote:
>> v5: rebase on master, some conflicts resolved due to data-file feature=


(Forgot to note that I'll look at the more interesting patches in this
series later today.  I just got so hung up on the benchmark...)


--Qsj9sux6gNz1BcXq7mdyuUd9HGDfgRGNz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlzGR6AACgkQ9AfbAGHV
z0Dw4gf/fgdDNz/mahIMu6tMOu+Ns7bORjmpGBu9q4vbLolurLdBBi0ZwE+QaCkm
R0aoBCwygppK5yd5EOTdQmzrWbjlZXWzfWMBgNHazJl0d2KMGw4VoBKadcpOZ54x
3VH042vpWem0c0Tw5h65hIdi2h0bw+GadadidclTKAALs/XvjPQVBcglfWXg97Bs
Sm7ZTLFphT/qNBm2d524YGhoVkMrQP7nh92SQzwHG52jploUpbjjay4huOenEXxs
eK7NbYMexLH+kg+iyTQvr6sIX/XvpnXHb5sDScO60AAJBT1+oItEpCxfmZ1hskH7
2p9GwShKH80Z2/1ApJ4pDJEK81tTWQ==
=mTPv
-----END PGP SIGNATURE-----

--Qsj9sux6gNz1BcXq7mdyuUd9HGDfgRGNz--

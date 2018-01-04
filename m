Received: from eggs.gnu.org ([2001:4830:134:3::10]:57308)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eX5RR-0001Bf-Ds
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 08:20:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eX5RQ-0005yS-Hh
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 08:20:17 -0500
Date: Thu, 4 Jan 2018 13:20:11 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180104132011.GF10106@stefanha-x1.localdomain>
References: <1513595351-5899-1-git-send-email-den@openvz.org>
	<1513595351-5899-5-git-send-email-den@openvz.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AH+kv8CCoFf6qPuz"
Content-Disposition: inline
In-Reply-To: <1513595351-5899-5-git-send-email-den@openvz.org>
Subject: Re: [Qemu-devel] [PATCH 4/5] block/parallels: replace some magic
 numbers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Denis V. Lunev" <den@openvz.org>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Klim Kireev <klim.kireev@virtuozzo.com>


--AH+kv8CCoFf6qPuz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 18, 2017 at 02:09:10PM +0300, Denis V. Lunev wrote:
> From: Klim Kireev <klim.kireev@virtuozzo.com>
>=20
> Signed-off-by: Klim Kireev <klim.kireev@virtuozzo.com>
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> CC: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  block/parallels.h | 2 ++
>  block/parallels.c | 5 +++--
>  2 files changed, 5 insertions(+), 2 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--AH+kv8CCoFf6qPuz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaTioLAAoJEJykq7OBq3PIOsgH/Rb0dQMucAdLx5pNCW9OTNlv
JYntyjrsdcG3nCKEan9Z73GJBwualojk8bFpChW0qfwzjMGbgzXxEOdCWPAr8cBG
sQFEHQy/Mz71A3YNmzYYal2Z3yfXz/LGJqNQVCOdq05uuDgISYpDj40mICVi00XM
AoKgcG3iK6n+jfyg2tcq21Q+lV/q317QY6dsD1eNsXP4pyHn3xmDAeMb8S0/aC6m
dL/HB4DAZX4IOZXMsSTUXjfBQUBtiHCRiFs26DAvX4MHHBqEhRDQxIxJ0K8lAMjI
kMCMQzFEv7MPJrAO3FDRTwuOdmZs1ZWD2cNCyjoRWZ7feCz4GXeG6k0NG2fDqJs=
=EZE+
-----END PGP SIGNATURE-----

--AH+kv8CCoFf6qPuz--

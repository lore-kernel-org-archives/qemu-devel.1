Received: from eggs.gnu.org ([2001:4830:134:3::10]:41593)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d48Ii-00033g-HR
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 11:59:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d48Ie-0005DF-9U
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 11:59:20 -0400
Date: Fri, 28 Apr 2017 16:59:12 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170428155912.GE10286@stefanha-x1.localdomain>
References: <1493298053-17140-1-git-send-email-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ey/N+yb7u/X9mFhi"
Content-Disposition: inline
In-Reply-To: <1493298053-17140-1-git-send-email-armbru@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] replication: Make --disable-replication
 compile again
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, wencongyang@gmail.com, zhang.zhanghailiang@huawei.com, zhangchen.fnst@cn.fujitsu.com, qemu-stable@nongnu.org


--ey/N+yb7u/X9mFhi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 27, 2017 at 03:00:53PM +0200, Markus Armbruster wrote:
> Broken in commit daa33c5.
>=20
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  migration/colo.c | 12 ++++++++++++
>  monitor.c        |  5 +++++
>  2 files changed, 17 insertions(+)

Thanks, applied to my staging tree:
https://github.com/stefanha/qemu/commits/staging

Stefan

--ey/N+yb7u/X9mFhi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZA2bQAAoJEJykq7OBq3PIpJ0IAI4tv3zjaQE6KJoAhjO0YUty
8sLGYL0iC4PP1IC2FpbAb2f1JJaxZwLw4TiUl7PiYWb5lA6zHHRveaiiN8i1IZik
hNadcIuVEM6Q18iCWEsyl1HZZbSNl4x/y0YPNgEnIeE0KNT0OboUcioZ0NFv0mz2
Y9Demrz/PlUxG4Sog58aRRxDAlqjensGTxA0mFsyDSiritGH0Tyc1/kUCJiI6RUu
ip6DYePQAyWxEjFFc1W2ThQtrB+puBXpezT6697Y+GazI5dnWrW+ETU77a/u6cah
kQkv+FhfoJXdm/bq0Es+AzarhfUs2Gvj8cIDRTIBMGW8RpTbfyr2b322wKOn9dg=
=eUNK
-----END PGP SIGNATURE-----

--ey/N+yb7u/X9mFhi--

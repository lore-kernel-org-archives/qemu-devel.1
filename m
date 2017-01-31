Received: from eggs.gnu.org ([2001:4830:134:3::10]:54492)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cYZyJ-0005tB-Km
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 10:03:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cYZyI-0006VO-RE
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 10:03:51 -0500
Date: Tue, 31 Jan 2017 15:03:43 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170131150343.GT18804@stefanha-x1.localdomain>
References: <1482503344-6424-1-git-send-email-vsementsov@virtuozzo.com>
	<1482503344-6424-15-git-send-email-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MOeiELSuYwpLEKvX"
Content-Disposition: inline
In-Reply-To: <1482503344-6424-15-git-send-email-vsementsov@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH 14/21] block: add trace point on
 bdrv_close_all
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, jsnow@redhat.com, famz@redhat.com, den@openvz.org, pbonzini@redhat.com, jcody@redhat.com


--MOeiELSuYwpLEKvX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 23, 2016 at 05:28:57PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block.c            | 1 +
>  block/trace-events | 1 +
>  2 files changed, 2 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--MOeiELSuYwpLEKvX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYkKdPAAoJEJykq7OBq3PI6KoH/09NzCsik20c04PnEZ5M6/dY
tu6/7683hpAj42x9Bb8kQXCCG1QBRwycg8Yel9y2YoQniQ81GadsQ9rpZQwjzqFI
+1h3+XuZHD/wCZ1VqS0ddS825PWZW1A8N+aqxmKm/b59+A0kl8raasDdNLrp6faX
JC8FF8YD/PG/gt/5mQr7Y7VEY7KqQwNh+Y2oGlFtbmrKSBI2az7YA4GwSVWsE4q5
1uMynzrkdtp2s87kWsYNzvSQn5UeAIao8LHw2xGl/QvxHrOWFiy7SXdiCG/HuAuo
2mackOFkV/73g4sHYxowUzV+TG4wkj0lkBxJz7g8tB/901ytSfpEeDnSlFyw+4c=
=Qf8a
-----END PGP SIGNATURE-----

--MOeiELSuYwpLEKvX--

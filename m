Received: from eggs.gnu.org ([2001:4830:134:3::10]:49774)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cYZcS-0005pk-RB
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 09:41:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cYZcO-0007aS-UI
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 09:41:16 -0500
Date: Tue, 31 Jan 2017 14:40:59 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170131144059.GO18804@stefanha-x1.localdomain>
References: <1482503344-6424-1-git-send-email-vsementsov@virtuozzo.com>
	<1482503344-6424-10-git-send-email-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TYjWXklH5JTzT8n9"
Content-Disposition: inline
In-Reply-To: <1482503344-6424-10-git-send-email-vsementsov@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH 09/21] backup: separate copy function
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


--TYjWXklH5JTzT8n9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 23, 2016 at 05:28:52PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/backup.c | 103 ++++++++++++++++++++++++++++++++++-----------------------
>  1 file changed, 61 insertions(+), 42 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--TYjWXklH5JTzT8n9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYkKH7AAoJEJykq7OBq3PI+fYIAIYQ/EgvFg2UIyLMn2tGnIG0
aLXCeN0FAmG0O1DyT0gJ48DLsTZDCzZGA0N/j1IQb/CR1hFE3L9bxwQO+VlBsqKl
+oH9GVYCx3thtA7xwBHtjDn4nb2z1x8ydfibMdUwdmvaW36fnHp9FOSMB0OlQubL
j6jETE1L4E+b+iLTjo6sSLY5q5U2I4fR9qwb8dkfKxJ2H1h9hXNtTikXDUJpdghj
StcoC7DV9nWoBQ39HGBeWfldwXvAhfwYptRvswYZP/oMnN5GRDgCpCgSuELIKJJz
36nB098iiqK2q1z4lKlhKF/4qw4w6AwQ8hRa1SyzVAsge4FqiXuklgYGpUddyzQ=
=1HIP
-----END PGP SIGNATURE-----

--TYjWXklH5JTzT8n9--

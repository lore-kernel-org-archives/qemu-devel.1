Received: from eggs.gnu.org ([2001:4830:134:3::10]:56602)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fOgPQ-0001Zk-IQ
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 05:31:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fOgPP-00023L-SV
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 05:31:44 -0400
Date: Fri, 1 Jun 2018 10:31:37 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180601093137.GB8687@stefanha-x1.localdomain>
References: <20180601062849.28641-1-famz@redhat.com>
	<20180601062849.28641-2-famz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pvezYHf7grwyp3Bc"
Content-Disposition: inline
In-Reply-To: <20180601062849.28641-2-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v8 01/11] docker: Update fedora image to 28
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Peter Lieven <pl@kamp.de>, Max Reitz <mreitz@redhat.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, eblake@redhat.com


--pvezYHf7grwyp3Bc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 01, 2018 at 02:28:39PM +0800, Fam Zheng wrote:
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  tests/docker/dockerfiles/fedora.docker | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Seems reasonable, Fedora is a cutting-edge distro.  Unlike stable
distros like CentOS and Debian where we actually want the oldest
supported release, we want the latest release for Fedora.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--pvezYHf7grwyp3Bc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbERJ5AAoJEJykq7OBq3PI0yMH/AhnVqZO8px8U5SX6Ph1h00r
ji/1QcISzvntN7FgHfbSuh+obOAi8Q2WM4RZtLyw8qKxvSDopeaSZV/IjaxktJL5
LjBRTTrHOq2JIDbh1edDA1fqpy/AHOqmx2olhadX4o213sxyUseFZX7wLfZN+r1n
/IgyXM9zqQbEoINA6zMer8Bnw4l6hK7H0EKrQcS6OkzF9sO5FdUfpR0Hpp8jkKRp
pt41IH0tQdiDyIQkXyvTAUFkmaV4Y4qJHaPs1VdSYzbkYsBqQEkBQNNLq23qJ2Ac
/ClUEpg/udc3mUj5GNjGNiy/WLCdZdn3qiQx5X2E6ax01W7mVDA2lZIWGhvF2ew=
=sFZ7
-----END PGP SIGNATURE-----

--pvezYHf7grwyp3Bc--

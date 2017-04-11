Received: from eggs.gnu.org ([2001:4830:134:3::10]:38938)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cxt4L-0006mZ-8w
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 06:30:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cxt4K-0003vn-D8
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 06:30:41 -0400
Date: Tue, 11 Apr 2017 11:30:27 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170411103027.GB17943@stefanha-x1.localdomain>
References: <20170410150542.30376-1-famz@redhat.com>
	<20170410150542.30376-2-famz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eAbsdosE1cNLO4uF"
Content-Disposition: inline
In-Reply-To: <20170410150542.30376-2-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for 2.9 v3 01/10] block: Make
 bdrv_parent_drained_begin/end public
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org, Ed Swierk <eswierk@skyportsystems.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>


--eAbsdosE1cNLO4uF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 10, 2017 at 11:05:33PM +0800, Fam Zheng wrote:
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  block/io.c            |  4 ++--
>  include/block/block.h | 16 ++++++++++++++++
>  2 files changed, 18 insertions(+), 2 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--eAbsdosE1cNLO4uF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJY7LBDAAoJEJykq7OBq3PIQvkH/Rz0RilScFZtrHtIqDLrtRik
RfVIbiXvbULBDvpWJOyCoupMB6mw0UIgFEHGt/JvR/k1dHOvlBQFB1A4L5hm8ruh
ekquIyfxclH7dBReT6+3um4vJIn5tAgfgTt+DjQejK8tGqgf1RXbI2hxLUA5KDVo
YjACl7R4iAnxNfRsvUvkcK5nadAO5laACaPAB24s0bw3NnLGWru1AYo/vQz7GRwD
AG8GKsJtpngXZbZXL3Ojnb4msmXmgnuiJL9RysF2zMKzVsSyg4wzDDCtucXXUbvd
KYgo93M2YBXqAl8Qw2T/cY5iKZsfQxcwhj4cM61902nagWoTSMCeFFeT9Pqi4qI=
=36Rl
-----END PGP SIGNATURE-----

--eAbsdosE1cNLO4uF--

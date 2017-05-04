Received: from eggs.gnu.org ([2001:4830:134:3::10]:33372)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d6G1m-0007zn-RR
	for qemu-devel@nongnu.org; Thu, 04 May 2017 08:38:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d6G1j-00008B-OS
	for qemu-devel@nongnu.org; Thu, 04 May 2017 08:38:38 -0400
Date: Thu, 4 May 2017 13:38:32 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170504123832.GI32376@stefanha-x1.localdomain>
References: <20170420120058.28404-1-pbonzini@redhat.com>
	<20170420120058.28404-4-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6b3yLyRKT1M6kiA0"
Content-Disposition: inline
In-Reply-To: <20170420120058.28404-4-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 03/17] block: access
 io_limits_disabled with atomic ops
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org


--6b3yLyRKT1M6kiA0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 20, 2017 at 02:00:44PM +0200, Paolo Bonzini wrote:
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  block/block-backend.c          | 4 ++--
>  block/throttle-groups.c        | 2 +-
>  include/sysemu/block-backend.h | 3 ++-
>  3 files changed, 5 insertions(+), 4 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--6b3yLyRKT1M6kiA0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZCyDIAAoJEJykq7OBq3PIJqYIAJVsyh3iMwFMwUR2rf+5RRY7
a7oJvn36DCm8Xr9SzSZvglQBroK1fq6enXU1oU45HR0iW3LojEAR+c7S1KBH9bVJ
BDioeAAjTV9LO5xERQwByi/J3Obp/A0p+mMiQVpPovYOFKnVg844W6lJgha3B9Pg
DCiC/b0AYFqAEy49fFzytgc5aIhYWqRPRSnSv0Bgh5r/LDMMuG/6FUeg31wZLHnL
zkp0u6/3S5eLkBswHkFkbY9zjDXLZIVBjH/pRwMykxYc4Cw+CGW481ye8g6FX2wZ
lOV24XhzROKdoKKzI0ac90/n8EbR4xsscdqwcR/rIculW5BsL2lgnjB1xd8oB5M=
=JRZd
-----END PGP SIGNATURE-----

--6b3yLyRKT1M6kiA0--

Received: from eggs.gnu.org ([2001:4830:134:3::10]:53033)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eZLYz-0000C0-S0
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 13:57:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eZLYy-0008Ax-Eh
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 13:57:25 -0500
Date: Wed, 10 Jan 2018 18:57:13 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180110185713.GI24212@stefanha-x1.localdomain>
References: <20180110091846.10699-1-famz@redhat.com>
	<20180110091846.10699-8-famz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CD/aTaZybdUisKIc"
Content-Disposition: inline
In-Reply-To: <20180110091846.10699-8-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 7/9] block: Move NVMe constants to a
 separate header
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Keith Busch <keith.busch@intel.com>, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Karl Rister <krister@redhat.com>


--CD/aTaZybdUisKIc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 10, 2018 at 05:18:44PM +0800, Fam Zheng wrote:
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  block/nvme.c         |   7 +-
>  hw/block/nvme.h      | 698 +-------------------------------------------------
>  include/block/nvme.h | 700 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 702 insertions(+), 703 deletions(-)
>  create mode 100644 include/block/nvme.h

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--CD/aTaZybdUisKIc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaVmIJAAoJEJykq7OBq3PIRyYIALot7E9WnUEn7sejEOcv6wds
fFdN+ai5l24oBT8okGgP9QBr10WCVXTJnLiKnYt3NbcMU5blc88Ec6q43S+7oE0U
1j2QNhvLJ9TAaK2Ql75drgKQDDYfuAHKda7b6m3OFxBgAIw/nuicGWRYroX5onNJ
13wyfa6dAv5YEYFKtsC5CeVTzF0/JG5JkIwRNu4YR8uNYWBiKuyAxeOlmfzyWwSf
GmeMnEBxsFJLe9yQ1RW6H8YT+keN3eS/8WniTgc4XK1dbAlLrXrRnynXKEfl0lp8
OSznL0aaOMfJczqmbaYXmbfu3QQVqdz/JxmQJ0eW8J1O6rjQLWAo1OcUhZ/InqI=
=a+/x
-----END PGP SIGNATURE-----

--CD/aTaZybdUisKIc--

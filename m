Received: from eggs.gnu.org ([2001:4830:134:3::10]:59307)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1g9Iv6-0004R8-Rk
	for qemu-devel@nongnu.org; Sun, 07 Oct 2018 19:57:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1g9Iv3-00022I-56
	for qemu-devel@nongnu.org; Sun, 07 Oct 2018 19:57:08 -0400
References: <cover.1537984851.git.jcody@redhat.com>
	<63e205cb84c8f0a10c1bc6d5d6856d72ceb56e41.1537984851.git.jcody@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <be63b6c3-6743-d152-07ad-18cfedc7f535@redhat.com>
Date: Mon, 8 Oct 2018 01:51:48 +0200
MIME-Version: 1.0
In-Reply-To: <63e205cb84c8f0a10c1bc6d5d6856d72ceb56e41.1537984851.git.jcody@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="uQcdxpr1s4wG8kFE0DB6QsNxqD11VgLCh"
Subject: Re: [Qemu-devel] [PATCH v2 2/2] MAINTAINERS: Remove myself as block
 maintainer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, qemu-block@nongnu.org, jsnow@redhat.com, kwolf@redhat.com, armbru@redhat.com, famz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--uQcdxpr1s4wG8kFE0DB6QsNxqD11VgLCh
From: Max Reitz <mreitz@redhat.com>
To: Jeff Cody <jcody@redhat.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, qemu-block@nongnu.org, jsnow@redhat.com,
 kwolf@redhat.com, armbru@redhat.com, famz@redhat.com
Message-ID: <be63b6c3-6743-d152-07ad-18cfedc7f535@redhat.com>
Subject: Re: [PATCH v2 2/2] MAINTAINERS: Remove myself as block maintainer
References: <cover.1537984851.git.jcody@redhat.com>
 <63e205cb84c8f0a10c1bc6d5d6856d72ceb56e41.1537984851.git.jcody@redhat.com>
In-Reply-To: <63e205cb84c8f0a10c1bc6d5d6856d72ceb56e41.1537984851.git.jcody@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 26.09.18 20:05, Jeff Cody wrote:
> I'll not be involved in day-to-day qemu development.  Remove myself as
> maintainer from the remainder of the network block drivers, and revert
> them to the general block layer maintainership.
>=20
> Move 'sheepdog' to the 'Odd Fixes' support level.
>=20
> For VHDX, added my personal email address as a maintainer, as I can
> answer questions or send the occassional bug fix.  Leaving it as
> 'Supported', instead of 'Odd Fixes', because I think the rest of the
> block layer maintainers and developers will upkeep it as well, if
> needed.
>=20
> Signed-off-by: Jeff Cody <jcody@redhat.com>
> ---
>  MAINTAINERS | 17 ++---------------
>  1 file changed, 2 insertions(+), 15 deletions(-)

Not sure who's going to merge this (maybe me, but then I'd like an ACK
from John on patch 1), but:

Acked-by: Max Reitz <mreitz@redhat.com>


--uQcdxpr1s4wG8kFE0DB6QsNxqD11VgLCh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlu6nBQACgkQ9AfbAGHV
z0DY0wf/U9v4RJYlkWiq5/AE/bCqh7PzMdZ3N4HfyUEVxbZ1XAne/gy+ZgCkrTZg
i4HxSL3MGya2k5nCehciNw9Wmfo7+T8GwCBEjcAquPcJozjX27s4R56iwo6KzYgi
1+kZ3AxzOy4oV601esQ2kXxMkw1sHLWjUR802w0v0si7xKB1vMyWv5qfANCX4VWN
qJkD9ar+KmzbBXqdvnvG3ShylUq3hRZuPrgh6P+BGb+v6fsNZS8ghNTuaziVt+Fe
EiB2D9i8O1GsjsyPORikGhyv9jt5ghpJXUAkXvZwxanGjw23VigjndZLO84x5kEK
iH9gBFSDzDLnW+oDghB0PqBmmlxGtQ==
=4i1N
-----END PGP SIGNATURE-----

--uQcdxpr1s4wG8kFE0DB6QsNxqD11VgLCh--

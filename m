Received: from eggs.gnu.org ([2001:4830:134:3::10]:48679)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dAdYV-0006e3-6Q
	for qemu-devel@nongnu.org; Tue, 16 May 2017 10:34:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dAdYR-0004RA-8u
	for qemu-devel@nongnu.org; Tue, 16 May 2017 10:34:31 -0400
Date: Tue, 16 May 2017 15:34:24 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170516143424.GC18270@stefanha-x1.localdomain>
References: <20170516074256.24731-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nmemrqcdn5VTmUEE"
Content-Disposition: inline
In-Reply-To: <20170516074256.24731-1-kraxel@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] block/win32: fix 'ret not
 initialized' warning
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Stefan Weil <sw@weilnetz.de>, "open list:raw" <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>


--nmemrqcdn5VTmUEE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 16, 2017 at 09:42:55AM +0200, Gerd Hoffmann wrote:
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  block/file-win32.c | 1 +
>  1 file changed, 1 insertion(+)

Thanks, applied to my staging tree:
https://github.com/stefanha/qemu/commits/staging

Stefan

--nmemrqcdn5VTmUEE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZGw3wAAoJEJykq7OBq3PIjAEIAJy1OiOGk2IUFvF61gnLUzNz
svIcaB2xgIP8kDyorDuZPDBKxiQLgw3B7obByW9AHjgGQI9KANhHHDtKhGY6klJp
01X3YXFKJnZc1S12h4T3hr4LAWTa0voZvw13Y2VIecZKY5ePnDCaAFctsnPE0P5o
wGWTXLCmSm5gkVKlrdopQLO+nffNg0o3NYxcJyYIGwh/cs/qHJwPlbmpmn+J2u/r
FP/Phpzq3V7lNTvPtE68Mdbnw8GYq2S1aE0MNQnsZ5Y+CQNodZPfhHO7clSSkE19
70r2BKOZmf5kt5ZAbrLLWG2iok5XIPbvKrLi42a7hVkfyMi6DTMTdZxriGkpG30=
=6WK4
-----END PGP SIGNATURE-----

--nmemrqcdn5VTmUEE--

Received: from eggs.gnu.org ([2001:4830:134:3::10]:48692)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eDBA9-0001zA-6M
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 10:24:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eDBA5-0002LA-4L
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 10:24:09 -0500
Received: from mail-wm0-x234.google.com ([2a00:1450:400c:c09::234]:52511)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1eDBA4-0002Jq-Tu
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 10:24:05 -0500
Received: by mail-wm0-x234.google.com with SMTP id t139so3473345wmt.1
	for <qemu-devel@nongnu.org>; Fri, 10 Nov 2017 07:24:04 -0800 (PST)
Date: Fri, 10 Nov 2017 15:24:01 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20171110152401.GA17290@stefanha-x1.localdomain>
References: <20171110090354.29608-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AqsLC8rIMeq19msA"
Content-Disposition: inline
In-Reply-To: <20171110090354.29608-1-kraxel@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] fix scripts/update-linux-headers.sh here
 document
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org


--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 10, 2017 at 10:03:54AM +0100, Gerd Hoffmann wrote:
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  scripts/update-linux-headers.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--AqsLC8rIMeq19msA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaBcSRAAoJEJykq7OBq3PIO90IAJx4In3zNcPIok6zAoBuXE2X
ca96LcC3FRaZykbTct/DpovXQEgdKD4leTkkvOn772Ofrcht3TC8mHapF6Z8qfIa
D7zfzydFsqgfaxUdUQDFTY3ALIJsPfqIMTjd4WUfQmLK/vBInXyhrrtjJqjB6MQ5
2zWsGrAdL/AKlcS2ZkX3MVICi7+ypm0DGin6raL7RARlFI2Ir76DaJnkfIj5DxLt
p+ko05iS83adOhM3dt5njFLbhA9AKVdtHqhILK9nut+O5via9P3aJe6QsIHrB5L+
gxbsQpmPdZuO47AVGARyQl6Ae3okWDQ/GFEWhyWAalMfq97ip7INWO5JuSwwUkg=
=XY6g
-----END PGP SIGNATURE-----

--AqsLC8rIMeq19msA--

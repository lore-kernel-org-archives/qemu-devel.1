Received: from eggs.gnu.org ([2001:4830:134:3::10]:37557)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eNFl1-0005C3-UE
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 05:19:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eNFku-0002EU-Iv
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 05:19:47 -0500
Date: Fri, 8 Dec 2017 10:19:41 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20171208101941.GF23880@stefanha-x1.localdomain>
References: <20171206144550.22295-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uTRFFR9qmiCqR05s"
Content-Disposition: inline
In-Reply-To: <20171206144550.22295-1-stefanha@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v2 0/9] blockdev: fix QMP
 'transaction' with IOThreads
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org


--uTRFFR9qmiCqR05s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 06, 2017 at 02:45:41PM +0000, Stefan Hajnoczi wrote:
> v2:
>  * Use StrOrNull for x-blockdev-set-iothread iothread argument [eblake]

Thanks for the reviews, Eric.

I will wait for one more block layer person (Kevin, Paolo, or Fam?) to
review before merging.

Stefan

--uTRFFR9qmiCqR05s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaKmc9AAoJEJykq7OBq3PIcZwIAI3T+IJDfLtXAUyYZXpNvTXn
BvXhCJbd8pvZvJflZXo0oOnbnl+tAVsYm0E1TqYsxYdfM8xG+N7yhZL+/C8+atBV
poxmWaS98ny636PIOMsN6a/d5zGK2H/3wzKmryvhwY2n2D0tfLVcF1esOj/+IyYn
iFPGf6oJJUVCnTVkKL3OEEIP3lr2tlRxMdBs0QTKWsOU+A/XkaknF3xHYf9RlzIs
JMPbLv1QSkRR0stwsbddzVigV7dqKvz7Vu6KM8GQYPCMUI096gEGK8PfCylsr2Bs
n16Yiml09MTwKdsCRKmXrSbYGAYpGOqa9VeA0ChJppnro/uXYjZaHM/3fVsCJvM=
=AKaA
-----END PGP SIGNATURE-----

--uTRFFR9qmiCqR05s--

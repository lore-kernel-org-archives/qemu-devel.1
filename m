Received: from eggs.gnu.org ([209.51.188.92]:60845)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1hIrpl-0004g9-IY
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 05:35:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1hIrgo-00074v-9y
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 05:26:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41174)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1hIrgn-00074a-SY
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 05:26:09 -0400
Date: Tue, 23 Apr 2019 10:26:03 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20190423092603.GE32465@stefanha-x1.localdomain>
References: <20190422004849.26463-1-richardw.yang@linux.intel.com>
	<20190422004849.26463-3-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OZkY3AIuv2LYvjdk"
Content-Disposition: inline
In-Reply-To: <20190422004849.26463-3-richardw.yang@linux.intel.com>
Subject: Re: [Qemu-devel] [PATCH v14 2/2] docs: Added MAP_SYNC documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Yang <richardw.yang@linux.intel.com>
Cc: qemu-devel@nongnu.org, xiaoguangrong.eric@gmail.com, pbonzini@redhat.com, pagupta@redhat.com, yu.c.zhang@linux.intel.com, mst@redhat.com, ehabkost@redhat.com, imammedo@redhat.com, dan.j.williams@intel.com, yi.z.zhang@linux.intel.com


--OZkY3AIuv2LYvjdk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 22, 2019 at 08:48:49AM +0800, Wei Yang wrote:
> From: Zhang Yi <yi.z.zhang@linux.intel.com>
>=20
> Signed-off-by: Zhang Yi <yi.z.zhang@linux.intel.com>
> ---
>  docs/nvdimm.txt | 22 +++++++++++++++++++---
>  qemu-options.hx |  5 +++++
>  2 files changed, 24 insertions(+), 3 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--OZkY3AIuv2LYvjdk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcvtorAAoJEJykq7OBq3PI2r8H/jT/ST7qNSmTpa42VotxXjCM
c71URkIRAY4bjjiZcqf+IiSZV4/Gqq4Zb9NzSBrPLfLhaNOnp6stDXHWZdB/fR3O
kRvCa9mUX21UsunWiAMoE869u9GX+oRo78JpYdZvvPm/6XkVoJ4QTQf51H9now3M
iieoqSpTldiyxOcnBEQf8bibcMwlQO8zoyY9/LEedvo36GWrDvHFMp+IOZURj4C/
rzPf54X6mbKYG1FJZdW9g/VLrfrx1eUs50P5PhOmXsE2IDf8bYIBCfiF+tuHomKC
pVc+UblnOs7RTIhj48ZnK/dTRimsIJh7YIjffa6ie4QzEEA9xm4LTeZRN7tMW0k=
=UwDf
-----END PGP SIGNATURE-----

--OZkY3AIuv2LYvjdk--

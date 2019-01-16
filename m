Received: from eggs.gnu.org ([209.51.188.92]:56026)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gjm9l-0003Xu-Et
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 09:27:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gjm9k-0007pr-RR
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 09:27:01 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d]:50724)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1gjm9k-0007m1-J8
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 09:27:00 -0500
Received: by mail-wm1-x32d.google.com with SMTP id n190so2198763wmd.0
	for <qemu-devel@nongnu.org>; Wed, 16 Jan 2019 06:27:00 -0800 (PST)
Date: Wed, 16 Jan 2019 14:26:57 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20190116142657.GF16898@stefanha-x1.localdomain>
References: <1547615970-23545-1-git-send-email-changpeng.liu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MZf7D3rAEoQgPanC"
Content-Disposition: inline
In-Reply-To: <1547615970-23545-1-git-send-email-changpeng.liu@intel.com>
Subject: Re: [Qemu-devel] [PATCH v2 1/3] contrib: compile vhost-user-blk
 tool by default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Changpeng Liu <changpeng.liu@intel.com>
Cc: qemu-devel@nongnu.org, sgazare@redhat.com, stefanha@redhat.com, mst@redhat.com


--MZf7D3rAEoQgPanC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 16, 2019 at 01:19:28PM +0800, Changpeng Liu wrote:
> Signed-off-by: Changpeng Liu <changpeng.liu@intel.com>
> ---
>  configure | 3 +++
>  1 file changed, 3 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--MZf7D3rAEoQgPanC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcPz8xAAoJEJykq7OBq3PInJEIAIZSpL8vMbS6tq0f5AFZz3cv
bw6NYGPIAYuhxsoUnNJmtrcnWtE5FjV3ZXSQAFEEyRQv/bJOofuEeumXbeMQs4X9
gzyi6QwAKJMvDfQvy7l0en8Uf8v5r05K2AnHz7n5J11q0TkDCVybIPkzMECHNe+A
5UXhA3rDrSUMzeyW3O5L8/1hekDJXbJ6sK2RJO7rVK553oupYqDzM+FWyHPLh8+R
oDTosIwwZ7iixaAjCiDhLhonluWHlrnRLGb7rFzJKuzAYfoVO3kh4cFMKaPlPFEQ
OsyvTmyeYPAcE18HqR76wjITwwHwZ/dN2KksgaevX0UOBNzB/sv0ncmMbmJSU9c=
=Ax1k
-----END PGP SIGNATURE-----

--MZf7D3rAEoQgPanC--

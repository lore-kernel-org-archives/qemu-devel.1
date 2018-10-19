Received: from eggs.gnu.org ([2001:4830:134:3::10]:48158)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gDTD2-0002yt-Hp
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 07:44:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gDTCx-0000KD-4G
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 07:44:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35416)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1gDTCw-0000JJ-TC
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 07:44:47 -0400
Date: Fri, 19 Oct 2018 12:44:42 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20181019114442.GF13137@stefanha-x1.localdomain>
References: <20181018201351.GA25286@beast>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="O98KdSgI27dgYlM5"
Content-Disposition: inline
In-Reply-To: <20181018201351.GA25286@beast>
Subject: Re: [Qemu-devel] [PATCH] nvdimm: Add docs hint for Linux driver name
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kees Cook <keescook@chromium.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Haozhong Zhang <haozhong.zhang@intel.com>, Eduardo Habkost <ehabkost@redhat.com>, Ross Zwisler <ross.zwisler@linux.intel.com>, qemu-devel@nongnu.org


--O98KdSgI27dgYlM5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 18, 2018 at 01:13:51PM -0700, Kees Cook wrote:
> I spent way too much time trying to figure out why the emulated NVDIMM
> was missing under Linux. In an effort to help others who might be looking
> for these kinds of things in the future, include a hint.
>=20
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  docs/nvdimm.txt | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Thanks, applied to my block tree:
https://github.com/stefanha/qemu/commits/block

Stefan

--O98KdSgI27dgYlM5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbycOqAAoJEJykq7OBq3PIPrIH/jFI6kkRKKBF8BQ5VS50RPqV
1WE25zA4b8KPzujCCaIBxT//xLcZmeTzR+7HZQQcYI+18fsGnS/baeSrYUZt3I3l
gHMN3MoWKx6NJoCvMCYXXU3SQESk5oDZ63FPpgftGoPOVv/NQPb04sSh3xYSI7ie
G3yXfNBEOS3aoQe8wlZA2ljnHDPUL2pPFccTKyztKNyRGYvHlogpJsH/CFq6q3NJ
NgOr7sLqRpti8AUuB7U8vFG0LLNQtcAKzVLiV9z+fK95WloL9nYO9wl7Um2zNEqa
Kons7JwEYMT3AU/bgWCraD8WVHa09P6k3VSFHY9O8PDHmJSU/UrXUyklcu5gGtc=
=yzRy
-----END PGP SIGNATURE-----

--O98KdSgI27dgYlM5--

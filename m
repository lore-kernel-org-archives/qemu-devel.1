Received: from eggs.gnu.org ([2001:4830:134:3::10]:60864)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fGjFm-0001Fk-T9
	for qemu-devel@nongnu.org; Thu, 10 May 2018 06:56:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fGjFj-0003g3-Q0
	for qemu-devel@nongnu.org; Thu, 10 May 2018 06:56:54 -0400
Date: Thu, 10 May 2018 11:56:48 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180510105648.GU1296@stefanha-x1.localdomain>
References: <1525840700-30635-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yRXsXhSYq7voLSEz"
Content-Disposition: inline
In-Reply-To: <1525840700-30635-1-git-send-email-thuth@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] MAINTAINERS: Add trace-events and
 qemu-option-trace.texi to tracing section
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org


--yRXsXhSYq7voLSEz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 09, 2018 at 06:38:20AM +0200, Thomas Huth wrote:
> The "trace-events" and "qemu-option-trace.texi" files in the top directory
> are currently "unmaintained" according to scripts/get_maintainer.pl. They
> obviously belong to the Tracing section, so add an entry for them there.
>=20
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  MAINTAINERS | 2 ++
>  1 file changed, 2 insertions(+)

Thanks for the discussion!

I'm happy to serve as a catch-all for trace-events patches (especially
trace events in unmaintained code).  It is preferrable for trace-events
changes to go via the subsystem, if there is a maintainer.

Thanks, applied to my tracing tree:
https://github.com/stefanha/qemu/commits/tracing

Stefan

--yRXsXhSYq7voLSEz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJa9CVwAAoJEJykq7OBq3PI4AUH/RQ2R9adL5riSVdMy90WtevA
sAylfye4u2ayp3EuftOsvtP5iDbjT/Wmdnw56WffMd7K7+coIXY6lmNBxPQbux/i
CS+nfKHDjSYWWgSXTru/sYmcAImSxxL9r49WIqQoMhEu9nLv+WhD6sLMIhIdQjQ9
aBd81W7ICjYtfAlCxbrT1yOqH9Oatayayp/C4uq+lr7om+SqmRZz1mKB3Zr9JDKe
7whaljD+nBgAIxUQAfiyhpQMGUpBb5jKquev7YV/jSPUkaiwTmeuAjomt3R+HltG
gf1PJ/GDyGPQBGYKEBuXgORGRwedhti1LRmO0GIVGoFoERNbEL6Me/HFMZ5gWd4=
=3+fr
-----END PGP SIGNATURE-----

--yRXsXhSYq7voLSEz--

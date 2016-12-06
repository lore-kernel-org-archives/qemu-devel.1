Received: from eggs.gnu.org ([2001:4830:134:3::10]:49848)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cEM2A-00039W-0b
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 15:08:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cEM26-0006qr-Rn
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 15:08:13 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36407)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cEM26-0006qm-Mb
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 15:08:10 -0500
Received: by mail-wm0-f65.google.com with SMTP id m203so23637275wma.3
	for <qemu-devel@nongnu.org>; Tue, 06 Dec 2016 12:08:10 -0800 (PST)
Date: Tue, 6 Dec 2016 20:07:08 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20161206200708.GB2521@stefanha-x1.localdomain>
References: <20161205105241.8585-1-lma@suse.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mxv5cy4qt+RJ9ypb"
Content-Disposition: inline
In-Reply-To: <20161205105241.8585-1-lma@suse.com>
Subject: Re: [Qemu-devel] [PATCH] tests: Ignore test-char binary
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Lin Ma <lma@suse.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com


--mxv5cy4qt+RJ9ypb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 05, 2016 at 06:52:41PM +0800, Lin Ma wrote:
> Commit ea3af47d added test for chardev unit tests, but didn't add
> the name of generated binary in .gitignore.
>=20
> Signed-off-by: Lin Ma <lma@suse.com>
> ---
>  tests/.gitignore | 1 +
>  1 file changed, 1 insertion(+)

Thanks, I have applied Changlong Xie's earlier patch but added your
commit description and name too.

Stefan

--mxv5cy4qt+RJ9ypb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYRxpsAAoJEJykq7OBq3PIOcwIAJgq7qDXCfl6/J+7WfMLdkVb
zKjioSKM1M8efrbefDpRxXD+++Zu8mtfDE6fZoaa1dNMNcHzasmxKvAUi3+TPsNF
lx+/enN2wGP6gowT+QGInQA2w7po0CwNADGNpukvbjgS8CyHh7O5FlGHiEA2YOLn
Azr1gh98PF0+uL9oLWCfTx+c4+50UJBv4usLznICRGAOv5J+sOwMW5umXNvgXsMt
C5JJvW42hBbK0R1443yuZ6QvKOrLMmp8MqBF4wnRqQNWrRcN+XYPkb10Q0t2uYYF
17tNhayjUUA1bADSvAuYlBO7GgjMTWxmITORC8pgfLho9E1KZ5H4O7aI0NwVDXs=
=Xo0k
-----END PGP SIGNATURE-----

--mxv5cy4qt+RJ9ypb--

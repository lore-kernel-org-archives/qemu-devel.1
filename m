Received: from eggs.gnu.org ([2001:4830:134:3::10]:41248)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1emiNd-0001o1-Qc
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 10:56:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1emiNa-00088E-Pv
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 10:56:57 -0500
Received: from mail-wm0-x230.google.com ([2a00:1450:400c:c09::230]:52428)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1emiNa-00087l-If
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 10:56:54 -0500
Received: by mail-wm0-x230.google.com with SMTP id t3so3971599wmc.2
	for <qemu-devel@nongnu.org>; Fri, 16 Feb 2018 07:56:54 -0800 (PST)
Date: Fri, 16 Feb 2018 15:56:51 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180216155651.GA17727@stefanha-x1.localdomain>
References: <20180213125143.23488-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YiEDa0DAkWCtVeE4"
Content-Disposition: inline
In-Reply-To: <20180213125143.23488-1-dgilbert@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] monitor.c: Fix infinite loop in monitor's
 auto-complete
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, t.pagef.lt@gmail.com, kwolf@redhat.com


--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2018 at 12:51:43PM +0000, Dr. David Alan Gilbert (git) wrot=
e:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>=20

Please include the details of how to trigger this bug.  This helps
justify the patch as well as aiding anyone investigating/backporting the
same issue in the future.

Aside from that:
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--YiEDa0DAkWCtVeE4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJahv9DAAoJEJykq7OBq3PIxQEIAIUiEHbn9e9fPoBhc6fs+hwk
yovRBx5PAF+RTPUss6R6RhQnXkACY9YOK6Ohwu0fkTRupC9Tcp7zI055K2B4o2jl
J3embv1IfP9nB8DEiY5Vqnej5r2l0lgdtMW5AGwsPUJje4sUlnmSzQuI2kM5yqh4
IMKBgwBwHd6dggk6d2Ckq+MT84i2IhB8wicC4nimmTAsc7fYPL5aQorzQN9Y/XFU
c+cpyAP9wgskMpE4mvNiLve2VpxrdZaegTBMAu/2KyZrk6+eXurpS9BnTp0daR0R
X7rjyf7Jo7y9V/12SCOiEyY5HjRbNWwqUiHVnQwxjZjfy5tOqYBH+sytR22h3i4=
=JqFA
-----END PGP SIGNATURE-----

--YiEDa0DAkWCtVeE4--

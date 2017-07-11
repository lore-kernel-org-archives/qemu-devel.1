Received: from eggs.gnu.org ([2001:4830:134:3::10]:42907)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dUxgK-0004ep-ME
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 12:06:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dUxgJ-0003K6-Os
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 12:06:36 -0400
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:34877)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dUxgJ-0003Jb-Ho
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 12:06:35 -0400
Received: by mail-wr0-x244.google.com with SMTP id z45so858568wrb.2
	for <qemu-devel@nongnu.org>; Tue, 11 Jul 2017 09:06:35 -0700 (PDT)
Date: Tue, 11 Jul 2017 17:06:32 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170711160632.GI31231@stefanha-x1.localdomain>
References: <20170704220346.29244-1-marcandre.lureau@redhat.com>
	<20170704220346.29244-15-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/8E7gjuj425jZz9t"
Content-Disposition: inline
In-Reply-To: <20170704220346.29244-15-marcandre.lureau@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 14/35] migration: mark coroutine_fn
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Juan Quintela <quintela@redhat.com>


--/8E7gjuj425jZz9t
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 05, 2017 at 12:03:25AM +0200, Marc-Andr=E9 Lureau wrote:
> Signed-off-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
> ---
>  migration/migration.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--/8E7gjuj425jZz9t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZZPeIAAoJEJykq7OBq3PI7V0H/RIl0+KRkmQruipwGbYn1R4G
stsTmgfL3NXlNIb0fb+O1WQUqTzXWnyxGPlnxcAgbcRan26VAFqp8dXcc/ACxxhi
RPSd2P7YVDwhkd3iWipgFY98gPhiME3uvMisXR/F6IipNdk4rn5HmSZpmGsM4Ud+
rcbaB+anm/r1S1ZbDd0QHLXBA3aNlaJb9f1eFU54QfqCDCIPb4gzAcZrJBinv942
rHEMKJ7s+El+9HlfsphrGaefk3+fMSIb8lJe+iibpsiZ1pXG7gr1e+4x7fyBE03W
OCIsWDUPsmLyg480gTxlCRKYITMqxB+USS66IG4sZ/1a8xp/hgpY7psk2jcn3hE=
=DLDy
-----END PGP SIGNATURE-----

--/8E7gjuj425jZz9t--

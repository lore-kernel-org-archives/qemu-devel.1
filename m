Received: from eggs.gnu.org ([2001:4830:134:3::10]:39358)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1df1Sa-0008He-FO
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 06:10:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1df1SW-0005bt-BA
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 06:10:00 -0400
Received: from mail-wm0-x22c.google.com ([2a00:1450:400c:c09::22c]:33042)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1df1SW-0005bO-4a
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 06:09:56 -0400
Received: by mail-wm0-x22c.google.com with SMTP id k20so5293702wmg.0
	for <qemu-devel@nongnu.org>; Tue, 08 Aug 2017 03:09:56 -0700 (PDT)
Date: Tue, 8 Aug 2017 11:09:53 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170808100953.GE16801@stefanha-x1.localdomain>
References: <20170804213625.3756-1-ehabkost@redhat.com>
	<20170804213625.3756-4-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="a1QUDc0q7S3U7/Jg"
Content-Disposition: inline
In-Reply-To: <20170804213625.3756-4-ehabkost@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.11 3/5] qmp-shell: execute_cmdargs()
 method
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com


--a1QUDc0q7S3U7/Jg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 04, 2017 at 06:36:23PM -0300, Eduardo Habkost wrote:
> This will allow us to execute a command that was already split in
> a list.
>=20
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  scripts/qmp/qmp-shell | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--a1QUDc0q7S3U7/Jg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZiY3xAAoJEJykq7OBq3PIQmUH/ir0okVty2n2l1Jl39oo2Lch
xup3s6PzoJVIsGSiskJocSqb4s559xJ7UiNzc4OkQPP8bPF7nxjLq/iFqi9iTEMp
aKnjqB6tFyfkzyAwj3EJFOqpaDTgBpUWWf9oxqQDaK8Tv5bullTg8vkRSKprRQGk
CwdP49PX0cKT7E+dl5+xWTMzzGjoGU6hJK+pS6sx7EO68Xq2OdNowaFHoJLfc91Y
XNb6m/8Y3paPEoMoVk2Xx7NsEn9v5YGbPwBC+9y7+wzfaWkcg7MtUiYbyDn3VBLD
eH5Cc40n4mz10O0vvdaKA8R6IvnzEW9ozaB4nbUh8sBNt/bZesk1p9tmOgdj3K4=
=EaPl
-----END PGP SIGNATURE-----

--a1QUDc0q7S3U7/Jg--

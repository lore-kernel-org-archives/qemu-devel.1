Received: from eggs.gnu.org ([2001:4830:134:3::10]:43412)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cpyDR-0002Mz-Rb
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 10:23:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cpyDN-00074F-VT
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 10:23:21 -0400
Received: from mail-wm0-x22b.google.com ([2a00:1450:400c:c09::22b]:36480)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cpyDN-00073n-PP
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 10:23:17 -0400
Received: by mail-wm0-x22b.google.com with SMTP id n11so64897846wma.1
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 07:23:17 -0700 (PDT)
Date: Mon, 20 Mar 2017 14:23:14 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170320142314.GA17887@stefanha-x1.localdomain>
References: <1489765795-32398-1-git-send-email-craig@rancher.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Jsn5+Lu/ZvzbAGtZ"
Content-Disposition: inline
In-Reply-To: <1489765795-32398-1-git-send-email-craig@rancher.com>
Subject: Re: [Qemu-devel] [PATCH] Add 'none' as type for drive's if option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Craig Jellick <craig@rancher.com>
Cc: qemu-devel@nongnu.org


--Jsn5+Lu/ZvzbAGtZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 17, 2017 at 08:49:55AM -0700, Craig Jellick wrote:
> Signed-off-by: Craig Jellick <craig@rancher.com>
> ---
>  qemu-options.hx | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--Jsn5+Lu/ZvzbAGtZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYz+XSAAoJEJykq7OBq3PIgIsIAIOhtR6UAwDBD4NJs0ZuChZd
nvguu6el/IU1wTKncipcYPPYc2/fWVWWG0n97BBwtpu6hmi7uZ7G8k4Oar663nP/
Vfaf6+M63q+XlGn+EvTscnCLmH03x0A+AM0fsYhWLfzqt7agQpBW6QnhQUwT0YZX
aOp0aDk2Ce9F0jSwJcPE4XO4ZKc59UbrH0RQEgQYWb9wRFdOqibAvCY+5vTaW5BC
emgUgqpnKH++riuc2yGlFy27Z3W2LycHssJJhO8xjhVJRwiWgfj/4NhzsAqroDJR
CDJOLzuXdU+1Xp/wiz6R6goj+vwIDlKNu8QHExiEYnPSUMoARWGdNfRB+duffEY=
=X+j9
-----END PGP SIGNATURE-----

--Jsn5+Lu/ZvzbAGtZ--

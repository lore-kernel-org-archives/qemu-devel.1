Received: from eggs.gnu.org ([2001:4830:134:3::10]:47084)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cYCkG-0003V0-9M
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 09:15:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cYCkC-0000qL-94
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 09:15:48 -0500
Received: from mail-wj0-x243.google.com ([2a00:1450:400c:c01::243]:35117)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cYCkC-0000q9-1t
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 09:15:44 -0500
Received: by mail-wj0-x243.google.com with SMTP id i7so7944870wjf.2
	for <qemu-devel@nongnu.org>; Mon, 30 Jan 2017 06:15:44 -0800 (PST)
Date: Mon, 30 Jan 2017 14:15:40 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170130141540.GI2118@stefanha-x1.localdomain>
References: <1485436265-12573-1-git-send-email-thuth@redhat.com>
	<1485436265-12573-6-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FK65GREB+Evh/hTL"
Content-Disposition: inline
In-Reply-To: <1485436265-12573-6-git-send-email-thuth@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH 5/5] checkpatch: reduce MAINTAINERS
 update message frequency
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>


--FK65GREB+Evh/hTL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 26, 2017 at 02:11:05PM +0100, Thomas Huth wrote:
> This is a port of the following commit from the Linux kernel:
>=20
> commit e0d975b1b439c4fef58fbc306c542c94f48bb849
> Author: Joe Perches <joe@perches.com>
> Date:   Wed Dec 10 15:51:49 2014 -0800
>=20
>     checkpatch: reduce MAINTAINERS update message frequency
>=20
>     When files are being added/moved/deleted and a patch contains an upda=
te to
>     the MAINTAINERS file, assume it's to update the MAINTAINERS file corr=
ectly
>     and do not emit the "does MAINTAINERS need updating?" message.
>=20
>     Reported by many people.
>=20
>     Signed-off-by: Joe Perches <joe@perches.com>
>     Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
>     Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
>=20
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  scripts/checkpatch.pl | 6 ++++++
>  1 file changed, 6 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--FK65GREB+Evh/hTL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYj0qMAAoJEJykq7OBq3PIlswH/izjmeerzGG/keq86ZhaEFpE
0dbBwSczMfMbanLsBTSRXEpHRuPUcKuSCHrapOCUQkR7gou+rxvwx7DkIKuRT0ds
8ETTE/SDEuGJRPKr3200VUblBsDl+y60xyBCPi9vYSOxU8zt/WMpmhtK5bQVMBWW
SoDQyih/i3fijjggN8316hSwPSpb9ph5k8iRx+tmH9Ds9VSNtN7KK7IeIOnZ6nqu
pELPzUEe7NgsrqNzi+EHEOoGk/DAES+7Q1KJFGpVXKT/hqVRjrmoC0+JjcePh6Il
ZcMdKCbyHDQuz6+Rx6YUgXmnJIGo2EKOjf+ZzXgXCTsZ+1YKh3KKUFB3U73JJVU=
=sBtj
-----END PGP SIGNATURE-----

--FK65GREB+Evh/hTL--

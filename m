Received: from eggs.gnu.org ([2001:4830:134:3::10]:57084)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dfaggioli@suse.com>) id 1gMxGm-0001a2-OW
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 10:39:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dfaggioli@suse.com>) id 1gMxGj-00032z-Ky
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 10:39:56 -0500
Received: from smtp.nue.novell.com ([195.135.221.5]:47198)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dfaggioli@suse.com>) id 1gMxGj-00031d-C0
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 10:39:53 -0500
Message-ID: <645c648a489b0a89aecac337ab9d1bcd6412a5f5.camel@suse.com>
From: Dario Faggioli <dfaggioli@suse.com>
Date: Wed, 14 Nov 2018 16:40:01 +0100
In-Reply-To: <ee022ac8-a83b-53c0-46d5-f2641a546240@redhat.com>
References: <154219299016.19470.9372139354280787961.stgit@wayrath>
	<154219301447.19470.4834273682384554888.stgit@wayrath>
	<ee022ac8-a83b-53c0-46d5-f2641a546240@redhat.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-yl1J9RRqGCq107WbH66J"
Mime-Version: 1.0
Subject: Re: [Qemu-devel] [RFC PATCH 1/3] i386: add properties for
 customizing L2 and L3 caches size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S.
	Tsirkin" <mst@redhat.com>


--=-yl1J9RRqGCq107WbH66J
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2018-11-14 at 08:14 -0600, Eric Blake wrote:
> On 11/14/18 4:56 AM, Dario Faggioli wrote:
> > ---
> >   0 files changed
>=20
> That's an odd diffstat. Why is git not giving you the normal
> diffstat=20
> with an actual summary of files changed?
>=20
Ah, more weirdness about this submission. :-O

I've just tried re-sending the series to myself and, for this patch, I
do see a diffstat that makes sense:

 include/hw/i386/pc.h |    8 ++++++++
 target/i386/cpu.c    |    8 ++++++++
 target/i386/cpu.h    |    3 +++
 3 files changed, 19 insertions(+)

And same is true for all other series I've sent around in the same way
and with the same tool (I went double checking a couple of them! :-P).

So, clearly, something went wrong this time. :-/

Regards,
Dario
--=20
<<This happens because I choose it to happen!>> (Raistlin Majere)
-----------------------------------------------------------------
Dario Faggioli, Ph.D, http://about.me/dario.faggioli
Software Engineer @ SUSE https://www.suse.com/

--=-yl1J9RRqGCq107WbH66J
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEES5ssOj3Vhr0WPnOLFkJ4iaW4c+4FAlvsQdIACgkQFkJ4iaW4
c+7o8RAA3/apWwuJns2maQLajvZHULUXic10kzccu9Djg10DoIjRsGq3WmOC2UYr
w17Sgl6xQaUD614llWiJTNMzW0dJxpO4OZ4b8c68YG7xDRzcoOKe7Q6AgQOQG1ee
rOoiHTdzA9oZLSFcgLDVpYhWIl7VojGTgNEIs0kUzupM3iFKpyVLcwCEY4L86adm
uUyDgoeNGJ8AZF3pIeKhsrECnA4IhHFfvWq2x1vXiCPRD21modQqqA/7IYuTDcnt
oJDUe7EJYjbbzamCfUoD/UwJV8aGpPpMcN6o19Bf1dfXzAxDdB+Hbl5rERihI3og
N9UP5KJt+Zy7Aw1SBepm9PaIog66t5aRmstXVvtGrVU7MtzS+PxitTExsf5AbWkg
7/Xe0A9d6bGaMiOqUqn5MdahgdH2rUk2tgN3lViiI7xi6+82B/7aOu18kKLD1IB4
KY9bxzZ2HqjSz5ZECCpIle+K2aaoqqISAX3U/ZuC8FM7YmoMMTVp00dUgxehCxXW
RY419RQrhtfZITkwNIT1y9yaA9wzf10pow0zVx5aDZVwqLNshe2OqAstx8ZwKZ+1
GOxd8Slj9gMWBRj5rtpowzbMyFVfEtMj1r3tUQSYmsm2Uui/XDlULOKZ0jyVmNmP
9BjooMumVQkPJq0j8rExY+HHR6OjxqgAJk6iA6z67qYzMStbaqI=
=aGBG
-----END PGP SIGNATURE-----

--=-yl1J9RRqGCq107WbH66J--

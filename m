Received: from eggs.gnu.org ([2001:4830:134:3::10]:42110)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cv6TW-0000EK-8A
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 14:13:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cv6TT-0000z4-2i
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 14:13:10 -0400
Received: from mail-wr0-x22a.google.com ([2a00:1450:400c:c0c::22a]:33961)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cv6TS-0000yX-Rn
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 14:13:06 -0400
Received: by mail-wr0-x22a.google.com with SMTP id t20so1651042wra.1
	for <qemu-devel@nongnu.org>; Mon, 03 Apr 2017 11:13:06 -0700 (PDT)
Date: Mon, 3 Apr 2017 19:13:03 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170403181303.GH3539@stefanha-x1.localdomain>
References: <1490984431.18559.2.camel@yandex.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oyqLL/JqMvClXZi1"
Content-Disposition: inline
In-Reply-To: <1490984431.18559.2.camel@yandex.com>
Subject: Re: [Qemu-devel] Project idea
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mihai-Drosi Caju <cajum.bugs@yandex.com>
Cc: qemu-devel@nongnu.org


--oyqLL/JqMvClXZi1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 31, 2017 at 09:20:31PM +0300, Mihai-Drosi Caju wrote:
> I'd be interested in submitting the following ideas:
> I'd like to enchance qemu's debugging capabilities.
> I was thinking to add an option to qemu to disable cpu reset on
> tripple-fault.
> Or adding support for breakpoints in the GDB stub while using kvm or
> another accelerator.
> Or emulating a JTAG port on a pty that would interface with the virtual
> CPU.

If you wanted to propose a custom project idea for Google Summer of Code
I'm afraid the application deadline has passed.

Custom project ideas require finding a mentor.  It usually takes at
least 2 weeks and also requires discussing the details of the project
idea.

You are welcome to contribute to QEMU outside of GSoC.  Guidelines on
submitting a patch are here:
http://wiki.qemu-project.org/Contribute/SubmitAPatch

Stefan

--oyqLL/JqMvClXZi1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJY4pCvAAoJEJykq7OBq3PIE64H/0CYV6rMRpCEkzM5iAaSdUIn
GvmgBxS/VMEAL7YPxhbqVE98LupLUgmff0XlYc3VFSLDbJKls+pFhu7C8vHacH3H
KTGatxYdjdpWRb4j8bzd9ksiXCvvZZn5ZmeXn9d243kumfYYe1C07Nw6YYDZ3Yhm
zW+NIm/Mu9LUZvN8+N+ZFCdIZsV67L2abeNsnx03I/2ujRFY0gTLihyVpWdgOXvz
wVO3U5alHxXdycgMIkXNj9v1CmVhRneuOHjwNPm61PIUbvqxc9Z28VVAqwv4nYJN
7GkgyJZewZxojO8TCnS0cTOGC6cQvVQN/d9QCdwnsRHZ0C5ewGPQzEhruRhFM7I=
=Oiaj
-----END PGP SIGNATURE-----

--oyqLL/JqMvClXZi1--

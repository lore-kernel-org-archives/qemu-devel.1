Received: from eggs.gnu.org ([2001:4830:134:3::10]:54661)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dbA7J-0003ae-Em
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 14:36:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dbA7I-000180-Fy
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 14:36:05 -0400
References: <20170728012542.29975-1-f4bug@amsat.org>
	<20170728012542.29975-3-f4bug@amsat.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <fae20dad-fec6-24cc-db4e-a0f64e1fc8ca@redhat.com>
Date: Fri, 28 Jul 2017 13:35:56 -0500
MIME-Version: 1.0
In-Reply-To: <20170728012542.29975-3-f4bug@amsat.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="5uwtjmibBoCuCPOrPMTxFKPn5hfPgAqGF"
Subject: Re: [Qemu-devel] [PATCH for 2.10 2/8] docs: fix broken paths to
 docs/interop/qcow2.txt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Alberto Garcia <berto@igalia.com>, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Cc: qemu-trivial@nongnu.org, qemu-block@nongnu.org, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5uwtjmibBoCuCPOrPMTxFKPn5hfPgAqGF
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Alberto Garcia <berto@igalia.com>, Max Reitz <mreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
Cc: qemu-trivial@nongnu.org, qemu-block@nongnu.org, qemu-devel@nongnu.org
Message-ID: <fae20dad-fec6-24cc-db4e-a0f64e1fc8ca@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for 2.10 2/8] docs: fix broken paths to
 docs/interop/qcow2.txt
References: <20170728012542.29975-1-f4bug@amsat.org>
 <20170728012542.29975-3-f4bug@amsat.org>
In-Reply-To: <20170728012542.29975-3-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/27/2017 08:25 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

The commit message in 1/8 was a lot nicer, in referring to which commit
broke the linkage.

(When backporting patches, a very common thing to do is 'git log' and
then grep for the commit id being backported - if any other commits
refer to the same id, then it's probably a good idea to consider
backporting those other commits as well. But it only works when there is
a good chain of 'patch B fixes patch A' in commit messages)


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--5uwtjmibBoCuCPOrPMTxFKPn5hfPgAqGF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAll7hAwACgkQp6FrSiUn
Q2pgfAgAlxacBJbFu7ju7V/xVednRszXwZ0do1m2AuxBykyU4sHafly0XZinqrCg
nSr58kvzqwuj6pkh0dQVCHzE/910Ayv+wXSKTAGyRCljNiML2kk+v/F5UmU4CzJP
gK371Ch2iBhRAmX9CzE5cKriBAhFlkY7xB6Eb7KaoVBEwBcRvhUVoDjIdAhwidxn
WdLxZMRz2DX/9odpd1gH+iW2UHOm3S7MXEcvAMUK4OTc2ajC/cw1n42HhV0XaEvx
dOmBO28AKbZjl207XJki48YRHZKe7e1oFEZBTL6t8fxFSu8Z4NLHMXyAMmr19W8e
kcPCyQoO5jovi2LeqEf31rZZ36q6LA==
=Z9Qd
-----END PGP SIGNATURE-----

--5uwtjmibBoCuCPOrPMTxFKPn5hfPgAqGF--

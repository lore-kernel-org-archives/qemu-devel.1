Received: from eggs.gnu.org ([2001:4830:134:3::10]:49157)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cirBJ-0003di-GP
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 18:27:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cirBE-0003Bv-Tp
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 18:27:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33638)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cirBE-0003Bi-NT
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 18:27:40 -0500
References: <CAH==99Q=77SBCcJvcfL8Nk8-GF+THPSjGzgfMVOyUu-WLRn8aA@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <2dbde154-81cb-fc58-9fca-11940cdf24da@redhat.com>
Date: Tue, 28 Feb 2017 17:27:38 -0600
MIME-Version: 1.0
In-Reply-To: <CAH==99Q=77SBCcJvcfL8Nk8-GF+THPSjGzgfMVOyUu-WLRn8aA@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="DLVjl9fJfBXEcoUFAiXdXoxpPlOfBUjCg"
Subject: Re: [Qemu-devel] how can i join and start?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jyoti Panwar <jyotipanwar110@gmail.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--DLVjl9fJfBXEcoUFAiXdXoxpPlOfBUjCg
From: Eric Blake <eblake@redhat.com>
To: Jyoti Panwar <jyotipanwar110@gmail.com>, qemu-devel@nongnu.org
Message-ID: <2dbde154-81cb-fc58-9fca-11940cdf24da@redhat.com>
Subject: Re: [Qemu-devel] how can i join and start?
References: <CAH==99Q=77SBCcJvcfL8Nk8-GF+THPSjGzgfMVOyUu-WLRn8aA@mail.gmail.com>
In-Reply-To: <CAH==99Q=77SBCcJvcfL8Nk8-GF+THPSjGzgfMVOyUu-WLRn8aA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/28/2017 03:52 PM, Jyoti Panwar wrote:
> how can i started??  coding in this organisation.

Here's some useful links:
http://wiki.qemu-project.org/Contribute/SubmitAPatch
http://wiki.qemu-project.org/BiteSizedTasks

My general advice (not just for this list, but any project): subscribe
to the list, read the traffic for a few days, and start by reviewing any
patch that looks interesting to you. From there, you'll get a feel for
what your own patches should look like.  Don't be afraid to ask
questions; IRC may have better real-time response, while mailing lists
has better archival capabilities.  But do take time to at least search
if the same question has already been asked and answered before, so
people don't feel like they are repeating themselves.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--DLVjl9fJfBXEcoUFAiXdXoxpPlOfBUjCg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYtgdqAAoJEKeha0olJ0Nq6UoH/3aoLTkpOuJDQWt0DMa2ECwZ
ZRvKAz1fDBrQ4PHy8qg1dvYVNwXCf3dD+8X/cPtWYuazCO3RQlG4lTYRQqSCf6aL
RwiniiIvotpt/AI8r86qqdN28AdXWiFbJNBTAOPimq3GevtJjNaLhbptgm3ld2WU
wIPSwSj7sOhFea3KycbumYdtvdX36yBtzZ90z8aM986DrIDcIjiFKRm5tbZPuf4Z
Z2S9ZWd+ny5xgTeRwT1yxZFs2Qj5ZoHuf+4F3UOTfMn1H4vQglmBzU0dKetSQFpL
0ZWKiU5GJakWXbkPDPbpS4qH7r9wheX8LwZL4FmVqrqEdXg/syvSyZ8GMgpjiYQ=
=52TD
-----END PGP SIGNATURE-----

--DLVjl9fJfBXEcoUFAiXdXoxpPlOfBUjCg--

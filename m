Received: from eggs.gnu.org ([2001:4830:134:3::10]:42306)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1di64M-00041k-9m
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 17:41:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1di64L-0000Fc-DN
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 17:41:42 -0400
References: <1500537221-20556-1-git-send-email-armbru@redhat.com>
	<a7a4e4dd-8c2f-8014-6486-13f9a90a0341@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <46c38cbd-136a-4546-6204-e3044c50ef7b@redhat.com>
Date: Wed, 16 Aug 2017 16:41:30 -0500
MIME-Version: 1.0
In-Reply-To: <a7a4e4dd-8c2f-8014-6486-13f9a90a0341@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="xIaC5NcFGMbMAL1Xh0qMi508g6n4f6DOg"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v2 00/10] Correct two minor
 QMP interface design flaws
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org, quintela@redhat.com, dgilbert@redhat.com, mreitz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--xIaC5NcFGMbMAL1Xh0qMi508g6n4f6DOg
From: Eric Blake <eblake@redhat.com>
To: John Snow <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org, quintela@redhat.com,
 dgilbert@redhat.com, mreitz@redhat.com
Message-ID: <46c38cbd-136a-4546-6204-e3044c50ef7b@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v2 00/10] Correct two minor QMP
 interface design flaws
References: <1500537221-20556-1-git-send-email-armbru@redhat.com>
 <a7a4e4dd-8c2f-8014-6486-13f9a90a0341@redhat.com>
In-Reply-To: <a7a4e4dd-8c2f-8014-6486-13f9a90a0341@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/16/2017 04:34 PM, John Snow wrote:
> Looks like this series got no replies (maybe a failure of my mail
> filtering?) but it has since been merged, so purely for my own selfish
> purposes;

No replies to v2 due to the fact that the differences from v1 were
trivial enough to keep R-b from that spin (it was mostly conflict
resolution that required the respin).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--xIaC5NcFGMbMAL1Xh0qMi508g6n4f6DOg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmUvAoACgkQp6FrSiUn
Q2oQtgf+MGQkUyihYe5oMtg6TW8MdFdy6ReYxIrUsniGWaT/rVi8KHshbw9K27qf
Jd9mz854TjJDgLcC4txpxDLSkEi6Kda6lUOs6aPEbS/TUS7jjrU2qIZUwy0SGrZh
2PLzN8Hg88PUXrKvl9DDWkuQnKvvj9rlnRM5+zwVKJYUjGltluqDK13z44C+yYR9
4zi5Xk5r/TWCbzS/jJfwaEAFSRm/WVF67TnUiZGlfIJL3poAvKDgpiDZgS8NTjj6
6kIVSYbOAFf3VBwl0DSdNoRWPyaZT2zhNBSN63UcjujvhYTJ2OX6rR4cbiBx3Loj
Lz+oCIddTCQDzz0v937iG++1kQyrdg==
=TsCN
-----END PGP SIGNATURE-----

--xIaC5NcFGMbMAL1Xh0qMi508g6n4f6DOg--

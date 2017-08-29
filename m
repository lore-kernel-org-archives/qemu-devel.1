Received: from eggs.gnu.org ([2001:4830:134:3::10]:34205)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dmhpu-0005dx-NP
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 10:49:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dmhpo-0001QX-Vw
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 10:49:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58150)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dmhpo-0001QI-MG
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 10:49:44 -0400
References: <1504014481-7975-1-git-send-email-chugh.ishani@research.iiit.ac.in>
From: Eric Blake <eblake@redhat.com>
Message-ID: <9bc66b3f-b17d-1093-1d20-5a515ea3fcd3@redhat.com>
Date: Tue, 29 Aug 2017 09:49:36 -0500
MIME-Version: 1.0
In-Reply-To: <1504014481-7975-1-git-send-email-chugh.ishani@research.iiit.ac.in>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="6gPrNRTIF4GvWEXGdUtVjOSsQssGTdjAl"
Subject: Re: [Qemu-devel] [PATCH 0/3] QEMU Backup Tool
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ishani Chugh <chugh.ishani@research.iiit.ac.in>, qemu-devel@nongnu.org
Cc: jsnow@redhat.com, stefanha@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6gPrNRTIF4GvWEXGdUtVjOSsQssGTdjAl
From: Eric Blake <eblake@redhat.com>
To: Ishani Chugh <chugh.ishani@research.iiit.ac.in>, qemu-devel@nongnu.org
Cc: jsnow@redhat.com, stefanha@redhat.com
Message-ID: <9bc66b3f-b17d-1093-1d20-5a515ea3fcd3@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/3] QEMU Backup Tool
References: <1504014481-7975-1-git-send-email-chugh.ishani@research.iiit.ac.in>
In-Reply-To: <1504014481-7975-1-git-send-email-chugh.ishani@research.iiit.ac.in>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/29/2017 08:47 AM, Ishani Chugh wrote:
> This patch series is intended to introduce QEMU Backup tool.
> qemu-backup will be a command-line tool for performing full and
> incremental disk backups on running VMs. It is intended as a
> reference implementation for management stack and backup developers
> to see QEMU's backup features in action.
> This patch series contains three patches,
>                1) QEMU Backup command line tool.
>                2) Test for full backup.
>                3) Manpage for the tool.
>=20
> Ishani Chugh (3):
>   backup: QEMU Backup Tool
>   Test for full Backup
>   Add manpage for QEMU Backup Tool

It looks like you have previously sent series by the same title:
https://lists.gnu.org/archive/html/qemu-devel/2017-08/msg03774.html

Please remember to use 'git send-email -v2' when sending version 2 of a
series; it also helps to tell reviewers in the cover letter how version
2 differs from version 1.

More patch submission hints at
 http://wiki.qemu.org/Contribute/SubmitAPatch

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--6gPrNRTIF4GvWEXGdUtVjOSsQssGTdjAl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmlfwAACgkQp6FrSiUn
Q2rDrQf/UJXD4PDIM02ZVkXCTcQAUjusAqQKhECdZL9o4lsswCovRRfbo0MGJCzD
0MfPRcWZQcYhZpw+sjsA3oC+NhpdhoQaeQ//nsDn4ctVby/3lPVWUSjO3GNAjZ6S
xdxlRJcp1fsBQiH3LEdC+HhPn/maEHSbDTw5/O+D/geUzN1SXNuXA5XKAUI4xklz
653+6kJMUeiYBenGMLqIoaSEKI005nnil99E3r1/Aer3Ufb9+9Hj/Kx/bwxYGZAy
NTNrskENHD31BzV9//7mRaNqgLybfJaDLjbCHbpP28X9N026rkaUKt0tDhXxJ2xB
rbxkn3JRCT7I24jFTTnFfeFY35mrGw==
=JoFW
-----END PGP SIGNATURE-----

--6gPrNRTIF4GvWEXGdUtVjOSsQssGTdjAl--

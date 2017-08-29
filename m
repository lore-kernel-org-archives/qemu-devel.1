Received: from eggs.gnu.org ([2001:4830:134:3::10]:33783)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dmj6n-0004mE-0g
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 12:11:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dmj6j-0005jA-Ox
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 12:11:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44094)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dmj6j-0005it-FK
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 12:11:17 -0400
References: <1504021818-12128-1-git-send-email-chugh.ishani@research.iiit.ac.in>
From: Eric Blake <eblake@redhat.com>
Message-ID: <77ae2693-5738-9be6-4db5-1ce08703fdb7@redhat.com>
Date: Tue, 29 Aug 2017 11:11:08 -0500
MIME-Version: 1.0
In-Reply-To: <1504021818-12128-1-git-send-email-chugh.ishani@research.iiit.ac.in>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="bvxqO2TK0vAKGHRUrLpTu9giIleQ95LWV"
Subject: Re: [Qemu-devel] [PATCH v? 0/3] QEMU Backup Tool
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
--bvxqO2TK0vAKGHRUrLpTu9giIleQ95LWV
From: Eric Blake <eblake@redhat.com>
To: Ishani Chugh <chugh.ishani@research.iiit.ac.in>, qemu-devel@nongnu.org
Cc: jsnow@redhat.com, stefanha@redhat.com
Message-ID: <77ae2693-5738-9be6-4db5-1ce08703fdb7@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v? 0/3] QEMU Backup Tool
References: <1504021818-12128-1-git-send-email-chugh.ishani@research.iiit.ac.in>
In-Reply-To: <1504021818-12128-1-git-send-email-chugh.ishani@research.iiit.ac.in>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/29/2017 10:50 AM, Ishani Chugh wrote:
> This patch series is intended to introduce QEMU Backup tool.
> qemu-backup will be a command-line tool for performing full and=20
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

So, which version is this series up to?  We REALLY need the vNNN
designator in the subject line, so that we aren't wasting review time on
a stale version of the series that you have now sent multiple times.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--bvxqO2TK0vAKGHRUrLpTu9giIleQ95LWV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmlkhwACgkQp6FrSiUn
Q2pDUAf/deZ03KS/X89+lN0Fr+na/7U/RXoAv6JEalbsEEh6jaMMkDgaoemWoIr2
rHkr92vZ5sMwiRqn9hWSldzz0tLIARXRL21FFKSmRNnffYMQV0uowyWsYTPIMKem
OjbJ711HJK4DymgF3ZpaXcjE6+RI2rVqkU5iEAci9sp+soGUNwd0o3Pn1usDvp4c
djuOX3jZVUXoNus5NdCfWUpWkQvWzDfMoYSLpx9NJbneGPR5CEMZpJypv3U9Gaey
k7DpFkx4bBYa+SD5y4iIdrpE9v+pAVMAZ3U24ss4yK6ApKUSwv8rgQy4wevmq3D9
eFZUXiBNZ7/VhszLTIzQ8Z753rvdqg==
=gXB6
-----END PGP SIGNATURE-----

--bvxqO2TK0vAKGHRUrLpTu9giIleQ95LWV--

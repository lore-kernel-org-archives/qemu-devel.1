Received: from eggs.gnu.org ([2001:4830:134:3::10]:41807)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kash@tripleback.net>) id 1evrdk-0002Bh-0O
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 17:39:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kash@tripleback.net>) id 1evrdg-0004Sn-Ug
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 17:39:24 -0400
Received: from mail.tripleback.net ([198.50.226.104]:48946)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kash@tripleback.net>) id 1evrdg-0004SF-Ow
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 17:39:20 -0400
References: <1520888449-4352-1-git-send-email-babu.moger@amd.com>
From: Kash Pande <kash@tripleback.net>
Message-ID: <91d78df1-6034-1ec8-af89-e97c3d5e1d04@tripleback.net>
Date: Tue, 13 Mar 2018 17:39:15 -0400
MIME-Version: 1.0
In-Reply-To: <1520888449-4352-1-git-send-email-babu.moger@amd.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="II92n7cWs9Xr5ZPZZzyH0o3T1ksu0ik4K"
Subject: Re: [Qemu-devel] [PATCH v4 0/5] Enable TOPOEXT to support
 hyperthreading on AMD CPU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Babu Moger <babu.moger@amd.com>, pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, rkrcmar@redhat.com
Cc: mtosatti@redhat.com, qemu-devel@nongnu.org, kvm@vger.kernel.org, Gary.Hook@amd.com, Thomas.Lendacky@amd.com, brijesh.singh@amd.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--II92n7cWs9Xr5ZPZZzyH0o3T1ksu0ik4K
From: Kash Pande <kash@tripleback.net>
To: Babu Moger <babu.moger@amd.com>, pbonzini@redhat.com, rth@twiddle.net,
 ehabkost@redhat.com, rkrcmar@redhat.com
Cc: mtosatti@redhat.com, qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Gary.Hook@amd.com, Thomas.Lendacky@amd.com, brijesh.singh@amd.com
Message-ID: <91d78df1-6034-1ec8-af89-e97c3d5e1d04@tripleback.net>
Subject: Re: [PATCH v4 0/5] Enable TOPOEXT to support hyperthreading on AMD
 CPU
References: <1520888449-4352-1-git-send-email-babu.moger@amd.com>
In-Reply-To: <1520888449-4352-1-git-send-email-babu.moger@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Tested-by: Kash Pande <kash@tripleback.net>


--II92n7cWs9Xr5ZPZZzyH0o3T1ksu0ik4K
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFIBAEBCAAyFiEE5MQWwRLWQeWW1A0MLHWyk7icJXgFAlqoRQMUHGthc2hAdHJp
cGxlYmFjay5uZXQACgkQLHWyk7icJXgUPAf7BGXCxXUGHyPtuPdeH+Gl1tJ1QfSQ
Xw7zHWl6oAcDZw0qFe6+CANEfG67DIgYkNdXpn1zdgkWBOaDWfY4cG+K98uqiDta
C9XR9YRD0ougqQ4jNV8UUCX3O8cJoU47Cz4Aqrc6Nh52SVymZRNy6aMh2i0fqv7Z
TVdYiU3dIV/JPgyR1k2A3+LL6gPaegbXy4S4FzNqd03f5tPyipHwij6bvouhGGUO
lq4N7nNrI+SMkGkMfIVBQLxtKTrrwTCVnlspua8tY6baN/1EgIbihWdBx9k96Zf+
XzMq/bkW6o05gMbQtwDuCphNDIMwGTTWv2n6xWCtMG4ZaAPJkFsaB6vs1Q==
=ITg4
-----END PGP SIGNATURE-----

--II92n7cWs9Xr5ZPZZzyH0o3T1ksu0ik4K--

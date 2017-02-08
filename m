Received: from eggs.gnu.org ([2001:4830:134:3::10]:53198)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cbFmD-0002VB-DQ
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 19:06:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cbFmC-0003WR-E9
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 19:06:25 -0500
References: <20170123123056.30383-1-famz@redhat.com>
	<20170123123056.30383-7-famz@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <efad05e9-415e-f52b-d281-a056125a0229@redhat.com>
Date: Wed, 8 Feb 2017 01:06:14 +0100
MIME-Version: 1.0
In-Reply-To: <20170123123056.30383-7-famz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="IfAB8dGdS7KeQB2Vx9GV4wRHrtIKQvw4M"
Subject: Re: [Qemu-devel] [PATCH v12 06/16] iotests: 055: Don't attach the
 drive to vm for drive-backup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: "Daniel P. Berrange" <berrange@redhat.com>, qemu-block@nongnu.org, eblake@redhat.com, Kevin Wolf <kwolf@redhat.com>, rjones@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--IfAB8dGdS7KeQB2Vx9GV4wRHrtIKQvw4M
From: Max Reitz <mreitz@redhat.com>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: "Daniel P. Berrange" <berrange@redhat.com>, qemu-block@nongnu.org,
 eblake@redhat.com, Kevin Wolf <kwolf@redhat.com>, rjones@redhat.com
Message-ID: <efad05e9-415e-f52b-d281-a056125a0229@redhat.com>
Subject: Re: [PATCH v12 06/16] iotests: 055: Don't attach the drive to vm for
 drive-backup
References: <20170123123056.30383-1-famz@redhat.com>
 <20170123123056.30383-7-famz@redhat.com>
In-Reply-To: <20170123123056.30383-7-famz@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 23.01.2017 13:30, Fam Zheng wrote:
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  tests/qemu-iotests/055 | 32 ++++++++++++++++++--------------
>  1 file changed, 18 insertions(+), 14 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--IfAB8dGdS7KeQB2Vx9GV4wRHrtIKQvw4M
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAliaYPYSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AAxEH/1mex8vo9ZdUxBMR+5LYiTkmizXDFvcQ
SgXtZLOfBCsQWjHpGM7g09+9gWmi2jwni+MqM6zhHAmritWW2POODiu/zy9uOrkU
zCJiMS4Cih0aVUDOPKBQ0ZH/L2Y6eu3Y0o8UpHQk1iyH0dwd/S179QurF0EJLZhx
USnfpSrfZCBRXvOnGyHEkRUx/AVCt9/k4ChFelTsBWLX/0n0nrrClIdkkY2riura
qRDf+cbzddZkCElVgeISTsQ65reqptczMHVOtxyY8f2BBs5aUZaiBKMwSYVkQNvP
Kf328qWgY/d1aHqyO2IDXcG8ViXvf7fG733c6sDfcTvfQp/ZJpP0hWQ=
=07qf
-----END PGP SIGNATURE-----

--IfAB8dGdS7KeQB2Vx9GV4wRHrtIKQvw4M--

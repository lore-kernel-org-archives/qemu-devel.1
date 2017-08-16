Received: from eggs.gnu.org ([2001:4830:134:3::10]:55353)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dhydf-0007el-RD
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 09:45:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dhydc-0007Aa-O7
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 09:45:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45156)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1dhydc-000781-HT
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 09:45:36 -0400
Date: Wed, 16 Aug 2017 14:45:25 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170816134525.GA9691@stefanha-x1.localdomain>
References: <1502456640-9114-1-git-send-email-chugh.ishani@research.iiit.ac.in>
	<1502456640-9114-2-git-send-email-chugh.ishani@research.iiit.ac.in>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="d6Gm4EdcadzBjdND"
Content-Disposition: inline
In-Reply-To: <1502456640-9114-2-git-send-email-chugh.ishani@research.iiit.ac.in>
Subject: Re: [Qemu-devel] [PATCH 1/2] Add manpage for QEMU Backup Tool
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ishani Chugh <chugh.ishani@research.iiit.ac.in>
Cc: qemu-devel@nongnu.org, jsnow@redhat.com


--d6Gm4EdcadzBjdND
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 11, 2017 at 06:33:59PM +0530, Ishani Chugh wrote:
> +@item qemu-backup guest add --guest guestname --qmp socketpath [--tcp]

Is --tcp still necessary?  I thought you decided to use unix:/tcp:
socketpath syntax.

--d6Gm4EdcadzBjdND
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZlEx1AAoJEJykq7OBq3PI5ocH/iQ9+CwfGbKsCJcvotlYvEJv
j4tUcBnwxvyYBfsUcFtNtKj/NNZCfaT9HI54zJ3ycHj0/s7L7NOWzjd9u2mGCd7Z
2fmh8Dr4bDnlJ+rcAmJQts2OkRJXQtPAPuEBXB1E1iEq/9rvJH4Ly6x0vgcZSQlT
S8KI1RLHKSjF4+lRF5x9sE61Z7iQRMH/4WaKpvpN556KgaTpd79lLrPjzqSLXTTM
TGHs4WJqi4muDA9CFmAnzlaLuJQ6AXe82ftMjO5kC/+WjADnBXnwf08VGco8OIVo
LKF8/rWiNJeTcArUqQRrkOrg61/lmXRcISwUJeoQ3g+BIn5P5ZiYyERwYDu1QOI=
=Qsfv
-----END PGP SIGNATURE-----

--d6Gm4EdcadzBjdND--

Received: from eggs.gnu.org ([2001:4830:134:3::10]:59516)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fL7VA-0003IA-76
	for qemu-devel@nongnu.org; Tue, 22 May 2018 09:38:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fL7V5-0008OF-Eo
	for qemu-devel@nongnu.org; Tue, 22 May 2018 09:38:56 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52520 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1fL7V5-0008No-An
	for qemu-devel@nongnu.org; Tue, 22 May 2018 09:38:51 -0400
Date: Tue, 22 May 2018 14:38:49 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180522133849.GN21655@stefanha-x1.localdomain>
References: <1526682046-17414-1-git-send-email-changpeng.liu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="20XocjIeMTCm4X0r"
Content-Disposition: inline
In-Reply-To: <1526682046-17414-1-git-send-email-changpeng.liu@intel.com>
Subject: Re: [Qemu-devel] [PATCH] contrib/vhost-user-blk: enable protocol
 feature for vhost-user-blk
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Changpeng Liu <changpeng.liu@intel.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com


--20XocjIeMTCm4X0r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 19, 2018 at 06:20:46AM +0800, Changpeng Liu wrote:
> This patch reports the protocol feature that is only advertised by
> QEMU if the device implements the config ops.
>=20
> Signed-off-by: Changpeng Liu <changpeng.liu@intel.com>
> ---
>  contrib/vhost-user-blk/vhost-user-blk.c | 7 +++++++
>  1 file changed, 7 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--20XocjIeMTCm4X0r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbBB1pAAoJEJykq7OBq3PIPZMIAK8gsLa1t202VdxAQU3DpLbg
OF9qBKC2h+RQJpIQESIixJ9VPAv5ouCazfe2vcA0tiu+TsSD+fsvSOcK4XbstUIj
D9typt8gc4IZupI+ff38/ruxHQnpwm69kbF0Hzb2J/7s3Ro8NZWOK3uWH7+fWxx6
Q2lbg1QWMp0Cvl4fOnA51u3TYo9SEF6nOM5oNXKSrokakFCFO/AttqIqVfpWSZrX
BQx2LMn5X7MgDOaYN6woeQt6O5cLFrOS5kfNjoDxLhqSiqNW2f8GMFYcBAO/603J
CW/jZ/ru1UzTme2wsDui2M0OI/HMV/AhdS/5hlticGfKm0cBbFB7HMXGoPEwQ6A=
=+r8o
-----END PGP SIGNATURE-----

--20XocjIeMTCm4X0r--

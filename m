Received: from eggs.gnu.org ([2001:4830:134:3::10]:36380)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eQwQe-0001fK-Em
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 09:30:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eQwQd-0000Zz-Mk
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 09:30:04 -0500
Date: Mon, 18 Dec 2017 14:29:56 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20171218142956.GN16653@stefanha-x1.localdomain>
References: <20171214005953.8898-1-jsnow@redhat.com>
	<20171214005953.8898-8-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dZihrQ6eCIduWT38"
Content-Disposition: inline
In-Reply-To: <20171214005953.8898-8-jsnow@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 7/7] block/backup: use block_job_throttle
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: qemu-block@nongnu.org, kwolf@redhat.com, jcody@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com


--dZihrQ6eCIduWT38
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 13, 2017 at 07:59:53PM -0500, John Snow wrote:
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  block/backup.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--dZihrQ6eCIduWT38
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaN9DkAAoJEJykq7OBq3PIj+kH/jC1y1kQBHCMnnCMIevzm6oa
7fSvrbesgd1zNhHejWZ7xOL4C7HjEO+dLv0rfHNAp+3ESuQMvmOufEOwZL3MJNu8
QeKJuakVC7+dNfmim89v4hEeQsVSVJF9dl2FWJx2PIyMHNbH2aIHPYHOlpAfzTFa
cgTjVuSRMdysRgMJbpJ8OtkIHVbcmwu85MnIfCuSn8f2O+j5iHBJOb47BXooWPLe
fUnziQ5XvISANkdUQBfMFXR40Bd+AMLqDQwScp35MsY330bIZGgRQDisq4jnY82/
OAhKhQz5k+cN0zAn8RlQWQEt6y39S8FhVm3CVmQjyB5HO4n+LsC4832ih7bzHcQ=
=ey/K
-----END PGP SIGNATURE-----

--dZihrQ6eCIduWT38--

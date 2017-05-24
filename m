Received: from eggs.gnu.org ([2001:4830:134:3::10]:60761)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dDXtM-0000oK-Qf
	for qemu-devel@nongnu.org; Wed, 24 May 2017 11:08:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dDXtH-0004wI-SV
	for qemu-devel@nongnu.org; Wed, 24 May 2017 11:08:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49350)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1dDXtH-0004uu-Md
	for qemu-devel@nongnu.org; Wed, 24 May 2017 11:07:59 -0400
Date: Wed, 24 May 2017 16:07:53 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170524150753.GB23327@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="i9LlY+UWpKt15+FH"
Content-Disposition: inline
Subject: [Qemu-devel] Status of q35-lite?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: chao.p.peng@linux.intel.com
Cc: Paolo Bonzini <pbonzini@redhat.com>, Daniel Berrange <berrange@redhat.com>, rjones@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>, Rik van Riel <riel@redhat.com>, qemu-devel@nongnu.org


--i9LlY+UWpKt15+FH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Chao,
Last year there was an effort to make "built-in" hardware optional so
that VMs can be launched with a minimal set of devices.  You made SATA,
PIT, and SMBus optional.

What is the current status of this work?

Are there more devices that could benefit from an optional switch?

For reference, here is the discussion that kicked of the effort to make
some core devices optional:
"[RFC 0/9] Introduce light weight PC platform pc-lite"
https://lists.nongnu.org/archive/html/qemu-devel/2016-06/msg04842.html

Stefan

--i9LlY+UWpKt15+FH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZJaHJAAoJEJykq7OBq3PIodgH/0QlC79f5owfCyLzd53ap/NC
FwzFJz90NvYTa3P3rQEIpwxl5keNDLQiI92b1OeIU7s3X8s2Vzo4un2Sfxfbc7au
QwfNfKZy0SnEVeyFOXQLnTf39jaJf5zn7HN9EpjSOvCNuXmXnIh94UoBsgin6Ig3
D55bOoqkAfmai6DUJ/39mwywhU9sSMNDpcuSpFpuLY6rqRLCLRP/cwsi/jRgjGWn
7oiNFjv27QC8PN90jE9NYIioiefb6HAxHe5i5yeplQOR8flwFyYvKhkVj93G8/sj
oMZDgea2eM5dqPV9KNM9nVGBcVa2hsdxFM/4FELzbPhgMi3XHTLmdliXUQG4PPg=
=7WFS
-----END PGP SIGNATURE-----

--i9LlY+UWpKt15+FH--

Received: from eggs.gnu.org ([209.51.188.92]:48265)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1h1qAG-00076w-BD
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 05:22:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1h1qAF-0005bm-KK
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 05:22:12 -0500
Date: Thu, 7 Mar 2019 10:22:06 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20190307102206.GC2843@stefanha-x1.localdomain>
References: <1545387387-9613-1-git-send-email-baiyaowei@cmss.chinamobile.com>
	<20190306215633.GM6818@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uXxzq0nDebZQVNAZ"
Content-Disposition: inline
In-Reply-To: <20190306215633.GM6818@localhost.localdomain>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] tcmu: Introduce qemu-tcmu
 utility
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Yaowei Bai <baiyaowei@cmss.chinamobile.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org, Amar Tumballi <atumball@redhat.com>, Mike Christie <mchristi@redhat.com>, Prasanna Kalever <pkalever@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Xiubo Li <xiubli@redhat.com>


--uXxzq0nDebZQVNAZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 06, 2019 at 10:56:33PM +0100, Kevin Wolf wrote:
> Am 21.12.2018 um 11:16 hat Yaowei Bai geschrieben:
> * The first priority should be adding an in-process iscsi target that
>   can be managed with QMP, similar to the built-in NBD server.

Using the in-kernel SCSI target with TCMU, or do you mean implementing
the iSCSI network protocol inside QEMU?

Stefan

--uXxzq0nDebZQVNAZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcgPDOAAoJEJykq7OBq3PItG8H/A0/LaO7FM9S5dA8PaVcBEcH
dyuogvAmkIgBBPvtJA8+dtNdzj/ZNMYcPQIuxc+wqb9xlvezUd+al33blZdmcNW5
Ak2v4zuW9nas+OXuzOcvPS7AgnU3dWdoOlpsSV4kSQgtim2tRfaLqirNOFzjlVBn
uwowJpRx2Tc6COW3ULELtpcJuOzUmSuEcQNDOp9hFdrsX5fzTUl7vKxBiwMlizbY
6xFKnW+ed0WSsRS9kg5U4Dv9V5p94caYhd0gro9zirrMUzibdcicAW7FhUTh5oxT
5GUPhrq1d46sVEJgQ60X/deox3vJK8c3dv7FIJeQCQENFLzwATg5TjiB79jo62k=
=Tdbt
-----END PGP SIGNATURE-----

--uXxzq0nDebZQVNAZ--

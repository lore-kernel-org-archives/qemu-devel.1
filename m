Received: from eggs.gnu.org ([2001:4830:134:3::10]:54821)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ePUsf-00019A-So
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 09:53:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ePUsc-00083k-Nb
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 09:53:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54130)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1ePUsc-00081V-G7
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 09:52:58 -0500
Date: Thu, 14 Dec 2017 14:52:47 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20171214145247.GP14433@stefanha-x1.localdomain>
References: <20171205055200.16305-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="y6PvmTFIYclVmRST"
Content-Disposition: inline
In-Reply-To: <20171205055200.16305-1-peterx@redhat.com>
Subject: Re: [Qemu-devel] [RFC v5 00/26] QMP: out-of-band (OOB) execution
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <shajnocz@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>, marcandre.lureau@redhat.com, "Dr . David Alan Gilbert" <dgilbert@redhat.com>


--y6PvmTFIYclVmRST
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 05, 2017 at 01:51:34PM +0800, Peter Xu wrote:
> This version is mostly document update, and dropped the single patch
> that is migration related (will be put into postcopy recovery
> series).

I've finished reviewing this revision.  The overall approach looks good.

Stefan

--y6PvmTFIYclVmRST
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaMpA/AAoJEJykq7OBq3PIm0AIAKxMVZj0zqtr36JJIUkapKV2
PCJzAS0AyD6SDnpBy4uYORddC4qxDAYH/k9BQ2bZzbfDbb5/ABztQ2mh+prHiFyw
yoF2klsc7WFgxZIlQw4qGaal5BIEFx9FJJ1/G5TvwBeUYjvbZZEMMI1lLEPK2ZP1
lGZTZ6bLE8m1zA0LWfF8K0q39P+ZNjFKyO8DXKImCeLxAujaxmO9fS4GOnBuDLU1
Z0T+DmrHTM1WorbAK0uHz8aXoGhkBjK8FkFKl8lKNtJiLa6dPMSt2e4tC+LsZBYn
d3+E4DKc2XB/9/DPUH6E5WhvOYTShu8wuBpMSG3QgVNCZm3QyfRd1tvM+BVaPrw=
=xAmw
-----END PGP SIGNATURE-----

--y6PvmTFIYclVmRST--

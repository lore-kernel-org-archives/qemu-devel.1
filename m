Received: from eggs.gnu.org ([2001:4830:134:3::10]:56446)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cyFDY-0003aT-43
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 06:09:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cyFDV-0001IT-01
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 06:09:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50881)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cyFDU-0001IL-Pu
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 06:09:36 -0400
Date: Wed, 12 Apr 2017 11:09:22 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170412100922.GB26272@stefanha-x1.localdomain>
References: <BM1PR01MB0722EAF9BB6F0804187CF81984000@BM1PR01MB0722.INDPRD01.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wzJLGUyc3ArbnUjN"
Content-Disposition: inline
In-Reply-To: <BM1PR01MB0722EAF9BB6F0804187CF81984000@BM1PR01MB0722.INDPRD01.PROD.OUTLOOK.COM>
Subject: Re: [Qemu-devel] [PATCH] Changed malloc and free to g_malloc and
 g_free in util/envlist.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Prerna Garg <Prerna.Garg@live.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "kwolf@redhat.com" <kwolf@redhat.com>


--wzJLGUyc3ArbnUjN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Prerna,
Saurav Sachidanand recently sent a patch to do the same thing:

https://patchwork.ozlabs.org/patch/741100/

Unfortunately it looks like this is duplicated work.  Saurav's patch
will probably be merged since it's already been through review.

The BiteSizedTasks page advises:

"Before starting on one of these tasks, it would be wise to double-check
the list archives to ensure no one else has recently submitted similar
cleanups for the same task."

You can search the mailing list archives here:

https://lists.nongnu.org/archive/html/qemu-devel/

Stefan

--wzJLGUyc3ArbnUjN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJY7fzRAAoJEJykq7OBq3PIu6oH/i4TolwvXADjR1L3Ex4DM8Za
dvbqRbwsQbNEgB6AA2szuwQp0xj0f/A13kVf6cIGU+zA9Vo4Am5tZJQiJAmqqgWY
AixkkEkAkluJH1MPadGxgMw9mHAbC/aj88FlliKYOa9QdJqV9zU88w47XB8gvr5R
vlw2Endy4tJNlBCtSQIyzLz427SJxaazb719KUz7m/P1QFFd0wL0RkHM6O4DDKR1
JHKdIvlRl55TYplx2W3yj/5AoeaB89KBjk8GFiEwvgJZPiRddgAY5cKyznWTX6iv
l1xc3hLIdSwjnc5xyZmRKPduI9dzxBAn2BJJ10I1R3yRL7BMho7w8EZ4ChHxtZM=
=K/oi
-----END PGP SIGNATURE-----

--wzJLGUyc3ArbnUjN--

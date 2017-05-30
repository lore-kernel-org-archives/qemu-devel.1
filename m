Received: from eggs.gnu.org ([2001:4830:134:3::10]:40935)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dFdRv-0001JG-9v
	for qemu-devel@nongnu.org; Tue, 30 May 2017 05:28:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dFdRu-0005kO-8a
	for qemu-devel@nongnu.org; Tue, 30 May 2017 05:28:22 -0400
Received: from mail-wm0-x22b.google.com ([2a00:1450:400c:c09::22b]:37709)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dFdRu-0005kA-2n
	for qemu-devel@nongnu.org; Tue, 30 May 2017 05:28:22 -0400
Received: by mail-wm0-x22b.google.com with SMTP id d127so89475103wmf.0
	for <qemu-devel@nongnu.org>; Tue, 30 May 2017 02:28:21 -0700 (PDT)
Date: Tue, 30 May 2017 10:28:18 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170530092818.GI11362@stefanha-x1.localdomain>
References: <CAJSP0QU1gHgZbeBfL1y15FL9muD4G6r3MBYvVMVXTMj=GCB7oA@mail.gmail.com>
	<20170529155036.GA5910@noname.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3eH4Qcq5fItR5cpy"
Content-Disposition: inline
In-Reply-To: <20170529155036.GA5910@noname.redhat.com>
Subject: Re: [Qemu-devel] Throttling groups vs filter nodes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Manos Pitsidianakis <el13635@mail.ntua.gr>, Alberto Garcia <berto@igalia.com>


--3eH4Qcq5fItR5cpy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 29, 2017 at 05:50:36PM +0200, Kevin Wolf wrote:
> After writing this, my gut feeling is that -object might well be worth
> it.

Yes, a real -object would be cleanest.

Stefan

--3eH4Qcq5fItR5cpy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZLTsyAAoJEJykq7OBq3PIc7IIAKQWGZLJUvoGz8jjhoE8pWn8
CGaoemSAwo1nheM/84uNlNFIigvz9A0W0TNqVgIKSv8s4et/XXAtTBK7gLDEI6Np
Bs3a3cTDFC4hft70mPln4cOmURRZlLD/MeRnKGwD99mFXevmxVQ40MwSBRwARmuR
r2SmatGnkhNqSjPKwcuwi3VpPz5IRvir0MJxQTiqPZUBIua6obgimd3C4q9xhDhK
jeqv/RzBSFFv//0rpsctZtK+J4ZOM5/RRQV4HM5z4ozfdngILYE3csVjh34G67Iw
A5lHOJNCz1T1i5+haEyOHlExdJ4RckWT9vuQn2cGnUox1Ri02eeEaWxXSjdJwDw=
=X+wM
-----END PGP SIGNATURE-----

--3eH4Qcq5fItR5cpy--

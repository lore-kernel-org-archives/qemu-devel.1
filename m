Received: from eggs.gnu.org ([209.51.188.92]:34796)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1guclJ-0004Tr-3m
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 07:38:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1guclI-0004GK-8h
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 07:38:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44884)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1guclG-00049p-Iq
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 07:38:36 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 70204C0AD406
	for <qemu-devel@nongnu.org>; Fri, 15 Feb 2019 12:38:26 +0000 (UTC)
Date: Fri, 15 Feb 2019 12:38:24 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20190215123824.GC15131@stefanha-x1.localdomain>
References: <1550227757-10869-3-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="da4uJneut+ArUgXk"
Content-Disposition: inline
In-Reply-To: <1550227757-10869-3-git-send-email-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] build: clean trace/generated-helpers.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, eblake@redhat.com


--da4uJneut+ArUgXk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 15, 2019 at 11:49:17AM +0100, Paolo Bonzini wrote:
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  Makefile.target | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--da4uJneut+ArUgXk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcZrLAAAoJEJykq7OBq3PIPT0H/3CAFHmSU5DwdtGM209g2f0n
ICrtvg8KIE800ootwbYmJVTlw6WRNbey6bDzSL0zLEXfiesLcjea5/mdbJmbiafX
FYYhbeBe9I7japetUrD+bO0Zh4/lhdfnItjag+LO4CWGDVddEmwVQj+Jl1+WCzJj
yKPyrI6/Z9MIzJ1/jTDiWP+bR1JJF1AA6fv0ao6KJa40UrBakLaH6NdhU6lxUtwG
UHVfi/Ph0oxBd1GgkJLziYMXD0IvF8QgHglOeiRxsKpX9e1/OARhSjtBJt8CQJfv
l3Fn2rOZHCNBobiQUr5oP6AUY4eG4VGy/dpWa5MWZkn/aTopN6IONDvYg3dbBls=
=qR8Z
-----END PGP SIGNATURE-----

--da4uJneut+ArUgXk--

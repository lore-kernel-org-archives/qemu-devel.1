Received: from eggs.gnu.org ([2001:4830:134:3::10]:46529)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dhX95-0001uh-Ce
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 04:24:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dhX92-0003YR-8p
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 04:24:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46171)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1dhX92-0003YC-3U
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 04:24:12 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 24857788AD
	for <qemu-devel@nongnu.org>; Tue, 15 Aug 2017 08:24:11 +0000 (UTC)
Date: Tue, 15 Aug 2017 09:24:07 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170815082407.GB32702@stefanha-x1.localdomain>
References: <20170814162142.29666-1-stefanha@redhat.com>
	<150272911898.78.981462169854023805@dd743fd916bd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0ntfKIWw70PvrIHh"
Content-Disposition: inline
In-Reply-To: <150272911898.78.981462169854023805@dd743fd916bd>
Subject: Re: [Qemu-devel] [PATCH for-2.10 0/2] trace: fix simpletrace.stp
 flight recorder mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com


--0ntfKIWw70PvrIHh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 14, 2017 at 09:45:19AM -0700, no-reply@patchew.org wrote:
> === OUTPUT BEGIN ===
> Checking PATCH 1/2: trace: use static event ID mapping in simpletrace.stp...
> Checking PATCH 2/2: simpletrace: fix flight recorder --no-header option...
> ERROR: line over 90 characters
> #39: FILE: scripts/simpletrace.py:101:
> +    """Deserialize trace records from a file, yielding record tuples (event_num, timestamp, pid, arg1, ..., arg6).

This line was not changed by this patch.

Stefan

--0ntfKIWw70PvrIHh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZkq+nAAoJEJykq7OBq3PIZ6cH/33celZbwA5pcP4Cp7hGfMGG
7wD5c9ExIrWwy/ZuB8o0t39h7cxxV0tDQJVG/i2vG6dkgqpgF7DL88Aci6Nbale2
ngnvyOrxfpTJFtWMof0VpapwExCBWyBzG4iJJ0NJSDA7YMQm4OrMDMlSXaa3i+sV
O/DCc5vdXSpfUbt6m67GPliVv6aOrQrBajfsU8IyU4KHHV9iWAd3IFroo8sf1Ewi
LuLNZDDBe/ARN/EX4UB5YAmVZit5k7cm7gkJB2EDrzHYnsF6vzt9m68viEqyQPPB
0q5BZcceZAg88CiDsH/8YWC1fl/Upd3ZGbXiXcd9wGdtrVMHwBWncQOOVYfqeBs=
=QqLc
-----END PGP SIGNATURE-----

--0ntfKIWw70PvrIHh--

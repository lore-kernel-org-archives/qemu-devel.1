Received: from eggs.gnu.org ([2001:4830:134:3::10]:54337)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cWNb2-0007Se-Aw
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 08:26:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cWNaz-0000DU-Oa
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 08:26:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57124)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cWNaz-0000DL-Ik
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 08:26:41 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C36193D952
	for <qemu-devel@nongnu.org>; Wed, 25 Jan 2017 13:26:41 +0000 (UTC)
Date: Wed, 25 Jan 2017 13:26:38 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170125132638.GH10664@stefanha-x1.localdomain>
References: <20170124180420.12430-1-pbonzini@redhat.com>
	<20170124180420.12430-8-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="54u2kuW9sGWg/X+X"
Content-Disposition: inline
In-Reply-To: <20170124180420.12430-8-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 7/8] virtio: use VRingMemoryRegionCaches
 for descriptor ring
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com


--54u2kuW9sGWg/X+X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 24, 2017 at 07:04:19PM +0100, Paolo Bonzini wrote:
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  hw/virtio/virtio.c | 28 +++++++++++++---------------
>  1 file changed, 13 insertions(+), 15 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--54u2kuW9sGWg/X+X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYiKeOAAoJEJykq7OBq3PIYlgH/2eQbzDnzWWwDmizGUhPSTPd
lsu+uO8oD6NRUzjW5g/DIU1CE7OHAsQiV6Qwb8ZkB48iRT4xYyK1tppYUO0XY2aF
xUS5lFkPMXHlSvY/DNyv2pK4PNSvz8NATN38PEFvZhsGzIP7cPkAoIdeVN91KGIM
tfFcMCmQjCdQUivHuk1n3VeOyD8cizVVwiNgDRRHpFNv1Q9SAIHOPJSGJ1on4EoM
SQVMh4jRoBq+Y3ZIyW/wIk9byp3NmQ1nROxCbKoHoCMyc9aUqBkv0UiZwIp7zQkP
6cfpy+fRxTh26GijEp+oMkWTP6OHsQcLxzrKgJP9juoP9P2qoLakicUgDLLQ120=
=8JlD
-----END PGP SIGNATURE-----

--54u2kuW9sGWg/X+X--

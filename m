Received: from eggs.gnu.org ([2001:4830:134:3::10]:40711)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1f9Y42-0004yz-Lr
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 11:35:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1f9Y3y-00022X-Ku
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 11:35:06 -0400
References: <20180419072123.682-1-david@gibson.dropbear.id.au>
	<20180419183037.21826f8a@bahia.lan>
	<20180420021803.GC2434@umbus.fritz.box>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <53e6af87-5f29-95d9-a921-bdad5a8e1ed2@redhat.com>
Date: Fri, 20 Apr 2018 17:34:38 +0200
MIME-Version: 1.0
In-Reply-To: <20180420021803.GC2434@umbus.fritz.box>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="It2e6Ar9q4KNJiwh1oaXlsTKWzKtjt0nz"
Subject: Re: [Qemu-devel] [PATCH for-2.13] Clear mem_path if we fall back to
 anonymous RAM allocation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>
Cc: imammedo@redhat.com, ehabkost@redhat.com, clg@kaod.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--It2e6Ar9q4KNJiwh1oaXlsTKWzKtjt0nz
From: Paolo Bonzini <pbonzini@redhat.com>
To: David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>
Cc: imammedo@redhat.com, ehabkost@redhat.com, clg@kaod.org,
 qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Message-ID: <53e6af87-5f29-95d9-a921-bdad5a8e1ed2@redhat.com>
Subject: Re: [PATCH for-2.13] Clear mem_path if we fall back to anonymous RAM
 allocation
References: <20180419072123.682-1-david@gibson.dropbear.id.au>
 <20180419183037.21826f8a@bahia.lan> <20180420021803.GC2434@umbus.fritz.box>
In-Reply-To: <20180420021803.GC2434@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 20/04/2018 04:18, David Gibson wrote:
> Paolo et al, as with my earlier patches adding some extensions to the
> helpers for determining backing page sizes, if there are no objections
> can I get an ack to merge this via my ppc tree?

Yes, go ahead!

Thanks,

Paolo


--It2e6Ar9q4KNJiwh1oaXlsTKWzKtjt0nz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEE8TM4V0tmI4mGbHaCv/vSX3jHroMFAlraCI8ACgkQv/vSX3jH
roMdngf/XkPWjL7RZOulhe4fDtYQlnMxF899KThDOUV2kFkxgHtNH6t0aoVrLpR7
2qM5o3iSdyZc5dJZRkNpYfcY9uT95pYrJ+4YANEwGinR1B90jz1UAfQOyIjPg4m/
nuWf4q8ywPMnv0JJ/nrkrdsi01WXxpj0AxHkKn749MgSOu4CUOK5+Dwh26xM6PmH
XfFhr7GKujGm02etzISObY2VJ1wi+27lcKPftrQcubYXAewmntwOP06QBDf4uqgF
KHRdcJfdy1l38GDIfczWLhuh14F++Hmb6RkF/eeyt16jwJVOqJfnTzLD3lDxzfXn
NCYOTe2ZGMdmwSACgzH5lRfO9oX96g==
=F0Ps
-----END PGP SIGNATURE-----

--It2e6Ar9q4KNJiwh1oaXlsTKWzKtjt0nz--

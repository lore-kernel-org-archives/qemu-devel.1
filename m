Received: from eggs.gnu.org ([2001:4830:134:3::10]:34644)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cd9ok-0004uF-82
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 01:08:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cd9oi-0002qu-Vr
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 01:08:54 -0500
Date: Mon, 13 Feb 2017 17:06:46 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170213060646.GE25381@umbus>
References: <1486638518-171446-1-git-send-email-imammedo@redhat.com>
	<20170210113108.6798be14@nial.brq.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="+wcwqhATTmTB6/2m"
Content-Disposition: inline
In-Reply-To: <20170210113108.6798be14@nial.brq.redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/7] pc/spapr: unify handling of possible
 CPUs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, drjones@redhat.com, ehabkost@redhat.com, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, Bharata B Rao <bharata@linux.vnet.ibm.com>, Marcel Apfelbaum <marcel@redhat.com>


--+wcwqhATTmTB6/2m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 10, 2017 at 11:31:08AM +0100, Igor Mammedov wrote:
> On Thu,  9 Feb 2017 12:08:31 +0100
> Igor Mammedov <imammedo@redhat.com> wrote:
>=20
> [...]
> >=20
> > Series depends on:
> >   [PATCH 0/3] spapr: fix cpu core hotunplug call flow
> >   https://www.mail-archive.com/qemu-devel@nongnu.org/msg427214.html
> > which is staged for next pull req in SPAPR tree.
>=20
> David,
>=20
> could you merge it through your ppc tree as this series
> depends on above patches that are there but not in master yet.

Ok, I've merged it into ppc-for-2.9, including the v2 6/7 and 8/7.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--+wcwqhATTmTB6/2m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYoUz0AAoJEGw4ysog2bOS1wUP/0M3jyeO/UPjyb1sGwTfNwrR
kwy35TQQq6YH/WFP49WpeyUXr1JtcTN4PUPnpnNRLxlilIR8nEYJfsHp790FrCCi
+zooKP7gMSTLozMyqJNRGbZgRh52bHpvA9Q15vYZ4Xw+J+U34qMOGsrZcH3tskjD
2BSvg00K4khKyWJlVZY9Wd+goSPXgXGAI22+myRHMA6+ekj45phs/Ti3tZuSEOC5
z9LkAFHNwLN0nwbk1yl3iCJrv0gEevKxPr2GVG1guz2E/rF3jY3KtuD6ZIIbhDK5
1zLMQTIz8YVTSk+rkUDfwT+tDqwko6k8TKLHAcKkjSkeyPQkW8mLH1w5sTdNtw0h
Zr0WMcYVx2o9BRND+/u8vNj5aMCwFTmUAf25rd3yxG07QlryUQrz6u6SIDTiHp3E
MzMeLCvWQ1a2ghaClSmlk0DKMaTdIkW1p9ScTeXv9Y2m0xyLzbRjP7WEER8/ZpkX
C+0jpGfh1uDU2LqjVJ91jDpwSceS3b8ly76lexiKPgAbt7czlGVuqCb41JmNc/IU
G3MFzQpqAxD8GeatedPEjJ3DRsaLGClaIpkWNgYZuwcr2i2ZE4pinVHR+GUPje7f
waY/KJx8FyFkq0GJ0gsilWLdcuTtOBlldFNY25i9NnRqMavKppAXJ1iHbzAOtKI+
JceTdAqEpr5O0HN9NBOB
=7xyP
-----END PGP SIGNATURE-----

--+wcwqhATTmTB6/2m--

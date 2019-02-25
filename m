Received: from eggs.gnu.org ([209.51.188.92]:37601)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <n54@gmx.com>)
	id 1gyBfH-0005B9-CS
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 03:31:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <n54@gmx.com>) id 1gyBfG-00021n-DG
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 03:31:07 -0500
Received: from mout.gmx.net ([212.227.17.20]:54789)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <n54@gmx.com>) id 1gyBfC-0001pY-Gg
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 03:31:04 -0500
References: <20190202144531.5772-1-n54@gmx.com>
	<a3dc285c-496f-c2ad-126a-91b2e4690a5f@redhat.com>
	<d0b7bfcb-8894-5a06-8290-ac9daf5a05da@gmx.com>
	<fc6a0084-815c-5e4a-cd5c-11046f16f33b@redhat.com>
	<e2a4fad5-5a96-994d-e8d4-f129e0929522@gmx.com>
	<4e7b8587-02a4-4ad2-c297-db7a1231f0b6@gmx.com>
	<39f61014-bde0-bcbe-67ec-e479b8ab14ec@redhat.com>
	<26044929-af0b-dc8c-c042-a5d56779caa5@gmx.com>
	<9ee31aff-0a22-479c-3667-33998c061483@gmx.com>
	<CABgObfb22erktrGeOArTvF=0YMG3W8vHQT1+s0p9iRAMa4BvMA@mail.gmail.com>
From: Kamil Rytarowski <n54@gmx.com>
Message-ID: <394086e5-d2af-1073-6389-15f6c36d7334@gmx.com>
Date: Mon, 25 Feb 2019 09:31:40 +0100
MIME-Version: 1.0
In-Reply-To: <CABgObfb22erktrGeOArTvF=0YMG3W8vHQT1+s0p9iRAMa4BvMA@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="nQqPUBfGOPeO6DFxN0G6taJw97X2DwJIO"
Subject: Re: [Qemu-devel] [PATCH] target-i386: Enhance the stub for
 kvm_arch_get_supported_cpuid()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--nQqPUBfGOPeO6DFxN0G6taJw97X2DwJIO
From: Kamil Rytarowski <n54@gmx.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Message-ID: <394086e5-d2af-1073-6389-15f6c36d7334@gmx.com>
Subject: Re: [Qemu-devel] [PATCH] target-i386: Enhance the stub for
 kvm_arch_get_supported_cpuid()
References: <20190202144531.5772-1-n54@gmx.com>
 <a3dc285c-496f-c2ad-126a-91b2e4690a5f@redhat.com>
 <d0b7bfcb-8894-5a06-8290-ac9daf5a05da@gmx.com>
 <fc6a0084-815c-5e4a-cd5c-11046f16f33b@redhat.com>
 <e2a4fad5-5a96-994d-e8d4-f129e0929522@gmx.com>
 <4e7b8587-02a4-4ad2-c297-db7a1231f0b6@gmx.com>
 <39f61014-bde0-bcbe-67ec-e479b8ab14ec@redhat.com>
 <26044929-af0b-dc8c-c042-a5d56779caa5@gmx.com>
 <9ee31aff-0a22-479c-3667-33998c061483@gmx.com>
 <CABgObfb22erktrGeOArTvF=0YMG3W8vHQT1+s0p9iRAMa4BvMA@mail.gmail.com>
In-Reply-To: <CABgObfb22erktrGeOArTvF=0YMG3W8vHQT1+s0p9iRAMa4BvMA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 25.02.2019 08:10, Paolo Bonzini wrote:
> I have replied already.
>=20



Sorry, I don't have this mail in my mailbox for some reason.

The issue is gone with the following patch:

https://www.mail-archive.com/qemu-devel@nongnu.org/msg598417.html

Tested-by: Kamil Rytarowski <n54@gmx.com>

Please merge with qemu. Thank you in advance!



--nQqPUBfGOPeO6DFxN0G6taJw97X2DwJIO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJABAEBCAAqFiEELaxVpweEzw+lMDwuS7MI6bAudmwFAlxzp+wMHG41NEBnbXgu
Y29tAAoJEEuzCOmwLnZslk0P/1vy0szPKIi+NvHTFXlYDOniWQkAWriGQzh3rOCV
1peTUUL5jgZueO+KFzWq+lk8m1Yvun3psvnfqplvNEF7OkqJOgKt5BIF7J2hJgPy
IkLVax5gs95Rey5eykOPVsCw+enDXt2QMzd4DNjfLHmlzl78+ComXT874pnmAZ+e
l3DGpXqcSkBLNFo5vgWsAj8+ZeYUt8GXfd7yF9dMPeIbQ4tm9Hj+5qe40+OsJIOz
XYmafMTIC9qM2IgceMK1cfSPpVruplgq6b8vS/cztaznuR16M/lrVsR3hWAyl8v9
iSNxzTR3rCf2ThuvQfKRxGRiyj7oGJUM4Wu9NrJ6F7yspmlyRgqoW+7QzpmZy717
4DxKbf+KYkf3EFKa35PG5lOckpee0VqVSFIFUpy5IUKl2HIIK8bORHBe+NrKOIaP
TD6bBN2AJHiWGApxXG2Rr26NfGfuYjgiGqmmAHT80HIl2LyMsoMVur+jkrkXvANR
cdpWL9aQP9sDtKTF9Rk8fDbpWDg2kKOJjpvaP45/ayrfVyRpCCsYtkNAq2eIxxkF
zk9PGeNeXdlPiAbdQS7kXKHWTG4Fnj5Y1ydut/Kwhx236vkkD0x901vNy3Klaqr3
N2Rpy8cKfk4ycHKyJ7ASZF9zSRy4nu45I/1B/DCQ0kLe7xDg/GvUzUvFgaeVR9Bs
1y4A
=2Yfm
-----END PGP SIGNATURE-----

--nQqPUBfGOPeO6DFxN0G6taJw97X2DwJIO--

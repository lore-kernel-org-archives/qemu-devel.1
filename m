Received: from eggs.gnu.org ([209.51.188.92]:57992)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <n54@gmx.com>)
	id 1gmGir-0001PJ-Pw
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 06:29:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <n54@gmx.com>) id 1gmGiq-0004gz-Vn
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 06:29:33 -0500
Received: from mout.gmx.net ([212.227.17.20]:58763)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <n54@gmx.com>) id 1gmGiq-0004gh-MF
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 06:29:32 -0500
References: <20190123080005.31078-1-kraxel@redhat.com>
	<20190123080005.31078-5-kraxel@redhat.com>
	<484e921f-7cee-755d-12a9-02e8bf182fa4@redhat.com>
	<20190123093657.GC27270@redhat.com>
	<d7c274a7-00ac-d767-69fc-238b88cfd61b@redhat.com>
	<20190123101238.GD27270@redhat.com>
	<379cce5d-71e1-b210-c0de-c0b8a478de3a@gmx.com>
	<CAFEAcA-HOjPGz2U4wXJ_ujbUmHn1V2PohiL8wPkPz8iV6TPSig@mail.gmail.com>
	<52937a07-9462-6910-610c-5b1ee5d2541a@gmx.com>
	<CAFEAcA9tD+AaTMDgUXO-XAfw8ftsip2n6Ew=GwVbPgMFzo01-Q@mail.gmail.com>
From: Kamil Rytarowski <n54@gmx.com>
Message-ID: <04d70037-0ea3-9d92-0e65-da32cb7388d5@gmx.com>
Date: Wed, 23 Jan 2019 12:30:28 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9tD+AaTMDgUXO-XAfw8ftsip2n6Ew=GwVbPgMFzo01-Q@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="D1BpFIHNqS3gCBcwurfxOwD0UdZBF31aI"
Subject: Re: [Qemu-devel] [PATCH 4/4] [RfC] audio: probe audio drivers by
 default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Kamil Rytarowski <kamil@netbsd.org>, Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Brad Smith <brad@comstyle.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--D1BpFIHNqS3gCBcwurfxOwD0UdZBF31aI
From: Kamil Rytarowski <n54@gmx.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Kamil Rytarowski <kamil@netbsd.org>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Brad Smith <brad@comstyle.com>
Message-ID: <04d70037-0ea3-9d92-0e65-da32cb7388d5@gmx.com>
Subject: Re: [Qemu-devel] [PATCH 4/4] [RfC] audio: probe audio drivers by
 default
References: <20190123080005.31078-1-kraxel@redhat.com>
 <20190123080005.31078-5-kraxel@redhat.com>
 <484e921f-7cee-755d-12a9-02e8bf182fa4@redhat.com>
 <20190123093657.GC27270@redhat.com>
 <d7c274a7-00ac-d767-69fc-238b88cfd61b@redhat.com>
 <20190123101238.GD27270@redhat.com>
 <379cce5d-71e1-b210-c0de-c0b8a478de3a@gmx.com>
 <CAFEAcA-HOjPGz2U4wXJ_ujbUmHn1V2PohiL8wPkPz8iV6TPSig@mail.gmail.com>
 <52937a07-9462-6910-610c-5b1ee5d2541a@gmx.com>
 <CAFEAcA9tD+AaTMDgUXO-XAfw8ftsip2n6Ew=GwVbPgMFzo01-Q@mail.gmail.com>
In-Reply-To: <CAFEAcA9tD+AaTMDgUXO-XAfw8ftsip2n6Ew=GwVbPgMFzo01-Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 23.01.2019 12:16, Peter Maydell wrote:
> On Wed, 23 Jan 2019 at 11:09, Kamil Rytarowski <n54@gmx.com> wrote:
>>
>> On 23.01.2019 11:59, Peter Maydell wrote:
>>> On Wed, 23 Jan 2019 at 10:37, Kamil Rytarowski <n54@gmx.com> wrote:
>>>> OSS is the portable UNIX audio backend. We could point some flaws in=
 it,
>>>> but it's a good enough for portable UNIX applications. The question =
is
>>>> what UNIX-like desktop OS does not implement it or removed it.
>>>
>>> If your desktop's native audio API is pulse, like Linux's often
>>> is, then you want to use pulse directly, because the compat layers
>>> are (or were last time I looked) not great, and typically add
>>> in an extra thread and an extra layer of buffering, which means
>>> more latency or more audio dropouts or both.
>=20
>> Pulseaudio uses OSS backend on NetBSD anyway and we keep an in-kernel
>> mixer. So it adds nothing except additional intermediate layer.
>=20
> Yes, exactly -- if your native API is OSS, we should be using that.
> It's the compat layers that are problematic, so we can't just use
> a single portable API on all platforms.
>=20

OSS is +/- native for NetBSD, it uses a different selection of ioctl(2)s
and a thin compat layer in the kernel.

Maintaining a backend support for SunOS API (our current native audio)
does not win us at this point anything and it makes things worse as
there would be a need for more code to maintain. In my opinion it's
better to not add support for it in 3rd party software and look for
moving forward into sound subsystem on par with more modern solutions.
Until we will get there, the right thing is to use OSS.

>> For non-professional audio purposes OSS is good enough for such
>> applications.
>=20
> QEMU has to care about the buffering that compat layers add,
> because guest programs tend to work on the assumption that they're
> talking directly to the hardware and extra buffering trips them up.
>=20
> thanks
> -- PMM
>=20

Correct, we don't want a stack of unwanted software like pulseaudio.


--D1BpFIHNqS3gCBcwurfxOwD0UdZBF31aI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJABAEBCAAqFiEELaxVpweEzw+lMDwuS7MI6bAudmwFAlxIUFQMHG41NEBnbXgu
Y29tAAoJEEuzCOmwLnZsx8cQAKKpXidCHd3CppC9bioFCabAIc6+g1g5JKIE6S+R
NamgzT6GIRdnXo96ihspYSStTdEy8kSeu0vyqJzYLumj9ZMdT/G5fOgpsaweotHH
8HKi3Az8X+unzME5KOYfpEUheJPdRNCbOBznX8F5EkVj+1hF+80wlhlIoBp3nBOi
unjGzvJMTyttFS6g3XIVJ0RogwZiGA1pjOypLKlPD3Xn3DTKLcDF+vNozuZN/D6g
iuA+A5HHhFw512XCafXmiGCCRfOaNjrTGiJoC7RfSx6pOCLeIELgShOpmPHF+fE2
zXW61h+QhPiOjQidCzwGZowHLmVysJ80xfzYto/Uw0G9QW6Tp16NlRRM3fE04M9o
VQ7grzndJVmxkqvNwsKF8BZXBerynOdRAKp/RYfQk/drCys1g7bBa9sWymeBbwbi
vrlK6WC51UmLSHqcdmYNTjJ1KesmpS0BrfO5YhhtPtoiViF6Z+84VlzQa7ag74x2
p5LSw4GowiEjjP5X5AuveyZzkpir7WSGW0jhVaVrCUrdXgRXvXLP+YxkI0iDnFy6
C0FI09MOlP7F9zzm3QrhfmQsxbPUalFbVMbRqYmW9/Rwfvu6qovr3WPuKdKtNTSv
iciZSI35c6ibx1Xtusm7SwOasZjcePsiGSJnhr1cHl4oH+S12ZjeO+jWCOGF+psu
srmG
=MSns
-----END PGP SIGNATURE-----

--D1BpFIHNqS3gCBcwurfxOwD0UdZBF31aI--

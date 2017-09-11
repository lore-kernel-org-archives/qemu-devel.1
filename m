Received: from eggs.gnu.org ([2001:4830:134:3::10]:51087)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <n54@gmx.com>)
	id 1drVDu-0004nm-TZ
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 16:22:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <n54@gmx.com>) id 1drVDu-0008A1-6g
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 16:22:26 -0400
References: <20170911200002.4511-1-n54@gmx.com>
	<CAFEAcA-5uT+vMfoNRDkHadGo-O3S-_LOmgj5_7dQgCS8NVzfvA@mail.gmail.com>
From: Kamil Rytarowski <n54@gmx.com>
Message-ID: <b8cc160b-349a-4bd0-efcd-04871cd47f02@gmx.com>
Date: Mon, 11 Sep 2017 22:24:41 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-5uT+vMfoNRDkHadGo-O3S-_LOmgj5_7dQgCS8NVzfvA@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="3LhNWIxW0XXM9QA2ELWg2AgHQ7L4tBWie"
Subject: Re: [Qemu-devel] [PATCH] Rename round_page() to round_pageq()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3LhNWIxW0XXM9QA2ELWg2AgHQ7L4tBWie
From: Kamil Rytarowski <n54@gmx.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Trivial <qemu-trivial@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Message-ID: <b8cc160b-349a-4bd0-efcd-04871cd47f02@gmx.com>
Subject: Re: [Qemu-devel] [PATCH] Rename round_page() to round_pageq()
References: <20170911200002.4511-1-n54@gmx.com>
 <CAFEAcA-5uT+vMfoNRDkHadGo-O3S-_LOmgj5_7dQgCS8NVzfvA@mail.gmail.com>
In-Reply-To: <CAFEAcA-5uT+vMfoNRDkHadGo-O3S-_LOmgj5_7dQgCS8NVzfvA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11.09.2017 22:16, Peter Maydell wrote:
> On 11 September 2017 at 21:00, Kamil Rytarowski <n54@gmx.com> wrote:
>> This change fixes conflict with the DragonFly BSD headers.
>>
>> Signed-off-by: Kamil Rytarowski <n54@gmx.com>
>=20
> What's the rationale for calling it round_pageq()
> in particular?
>=20
> thanks
> -- PMM
>=20

It might be a bad taste, but q stands for qemu.. I'm going to send a
better patch soon with a switch to TARGET_PAGE_ALIGN().


--3LhNWIxW0XXM9QA2ELWg2AgHQ7L4tBWie
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZtvEPAAoJEEuzCOmwLnZsOpUP/2q+9Ithhnqe/lyFMI45JRKm
+3pv+YA4QfuWQ3N+YUjyRIoLX3ZsAVJcd/cJMj3+O3yrps7gV7NOZELR6W+AiD8M
wpk9cibnLvxdVR9nPsp2sLuWHT/LNJK2YC5envQVUaa2BhITCi7xL2Sd2CgXV3ex
ddxog6YoOhtIounrTf67QvwSv0gUAlQXTV6cmcu3UOHToo8TGlKKv1AeL8tIuAQu
JYJmixMokZzv5pu8c6Mgu2FolzZCN4060d0Tjk/fBFZOkFmfabvTmAwD9WZ3fcpu
t7xxI21zkCe9AZJBj0lDJ/j/UyC6Q0voeeP3JymDs7kJBn+16Fir1WA0v9fTRLP8
halCzYs7HOQDXn+tpVc3mk1E6na4nXTHGoRehYCmJOD7MsJoAG9yI0cPI+bs6rU7
Laf6YouRbhD59jOgNDuLElJzMK4X9y19CDyHY1XcxUYPOxNHpyUEk4kCMgNc4/0Y
4dx+BnAHa7LDTgNAs24drY+34HHw9uCiII1evea/v8u/DAkqHCOV0ng56EhaNtmR
iQIhkrjAHlojmfT8cnwBBChYIr19SmJ0BfP+U2U/HcUJiaqeXTeSbjFmWaqDMmvy
cdCB/p5WgQy+kJ6Wpo2BwkbnVmhCosfKFlGdKQMmKpgRaX1SVnj1G92GU3uBKJW8
ikN13WBNN+Z7ru4n/696
=QgZ/
-----END PGP SIGNATURE-----

--3LhNWIxW0XXM9QA2ELWg2AgHQ7L4tBWie--

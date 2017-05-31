Received: from eggs.gnu.org ([2001:4830:134:3::10]:35677)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <n54@gmx.com>)
	id 1dG1dq-00011i-Ps
	for qemu-devel@nongnu.org; Wed, 31 May 2017 07:18:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <n54@gmx.com>) id 1dG1dn-0007N2-Lo
	for qemu-devel@nongnu.org; Wed, 31 May 2017 07:18:18 -0400
Received: from mout.gmx.net ([212.227.17.22]:53894)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <n54@gmx.com>) id 1dG1dn-0007KQ-B2
	for qemu-devel@nongnu.org; Wed, 31 May 2017 07:18:15 -0400
References: <20170526054013.299-1-n54@gmx.com>
	<20170530062022.5841-1-n54@gmx.com>
	<58d04e43-1caa-f623-44fe-749dd351fad9@redhat.com>
	<42633e66-7ef4-c4ef-18d3-d2be588b816c@gmx.com>
	<6ee03c9d-3c42-4f73-1ca9-313f50be63df@redhat.com>
	<87k24xcmci.fsf@dusky.pond.sub.org>
From: Kamil Rytarowski <n54@gmx.com>
Message-ID: <3ac75b7e-4dc9-6149-011c-f0e54652cb86@gmx.com>
Date: Wed, 31 May 2017 13:20:01 +0200
MIME-Version: 1.0
In-Reply-To: <87k24xcmci.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="3GGPGkJ8O0K8LB1JwcHWtrc67Pn6cHUkT"
Subject: Re: [Qemu-devel] [PATCH] ivshmem-server: ivshmem-client: Build when
 eventfd() is available
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>
Cc: peter.maydell@linaro.org, marcandre.lureau@gmail.com, qemu-devel@nongnu.org, f4bug@amsat.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3GGPGkJ8O0K8LB1JwcHWtrc67Pn6cHUkT
From: Kamil Rytarowski <n54@gmx.com>
To: Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>
Cc: peter.maydell@linaro.org, marcandre.lureau@gmail.com,
 qemu-devel@nongnu.org, f4bug@amsat.org
Message-ID: <3ac75b7e-4dc9-6149-011c-f0e54652cb86@gmx.com>
Subject: Re: [Qemu-devel] [PATCH] ivshmem-server: ivshmem-client: Build when
 eventfd() is available
References: <20170526054013.299-1-n54@gmx.com>
 <20170530062022.5841-1-n54@gmx.com>
 <58d04e43-1caa-f623-44fe-749dd351fad9@redhat.com>
 <42633e66-7ef4-c4ef-18d3-d2be588b816c@gmx.com>
 <6ee03c9d-3c42-4f73-1ca9-313f50be63df@redhat.com>
 <87k24xcmci.fsf@dusky.pond.sub.org>
In-Reply-To: <87k24xcmci.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 31.05.2017 13:11, Markus Armbruster wrote:
> Eric Blake <eblake@redhat.com> writes:
>=20
>> On 05/30/2017 08:11 AM, Kamil Rytarowski wrote:
>>
>>>>
>>>> Is this a v2 patch? If so, it's best to repost it as a new top-level=

>>>> thread rather than buried in reply to your v1 patch.  Also, be sure =
to
>>>> include v2 in the subject line ('git send-email -v2' works wonders f=
or
>>>> that).
>>>>
>>
>>>
>>> I reworked it, fixed title and it's more like v3.
>>>
>>
>>> Do I still need to resend it?
>>>
>>
>> A human maintainer can often (eventually) figure out what's going on i=
f
>> you don't, but resending is easier if you want to ensure the automated=

>> patch tools don't lose things.
>=20
> Yes.
>=20
> However, ivshmem doesn't have a maintainer.  Since the patch is really
> simple, the easiest path forward could be sending a v3 with
> cc: qemu-trivial@nongnu.org.
>=20

OK, I will do this.


--3GGPGkJ8O0K8LB1JwcHWtrc67Pn6cHUkT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZLqbwAAoJEEuzCOmwLnZsgBkP/0wi3FTGJa35I66/6071DY6T
4QwHuIE3h/Al7y+6ALGh0cB5Yul/Ao2k8LgFtBHBRtzgUhJOtPvnPERYapDrIaI8
iLKSdVxjkNqRpiMf/5FmPJhsmZ5+sYPUShZTkw937GNS8hqly2qGsLec+bX6lhsx
G+cA6a3v8v/JoxOitet594YpzKQKPo8NeBXhxaXffZ1Vl3ivqsZB2gml9v/47S2R
sEzugsmA/y/4oGsA0ohO6iqbWklk0Jc/y3YGlReXnWGxAN/C5ymbmT5TZkjqWR9R
dv3U6FzBbO7Ux8t+MEwjhoPjXo4vHUSUZM+ERd2etYqBvFVsUJy9lgeuewbmIUgw
15qUkGvgwiY8vIC5ASwSWNGjDhPEbtYaDGFbPkrEpzbZypJy4j51TDpveYx3g23A
hQSpQp/dGG/CgUWs7NPc1ikjqraDeyyHKBk+IohieRwP4gFD1PU2rw+Lr9DMB+lt
KHv+DjIRB7oJ1KG6YGzk8Icf1UC+H7OPwztFQRX1AIKDxqIL27tPYgEJkbk1xaQ0
c1RndCsgCXfiRfYDgt/oYbBmfIadcLe5dNYa9290ypDcKL1Wmlj1oxJ5eN+jBMcC
16YK/AlwpAMwXvpTEU0ayb6eQVKBe9p5oIe0224R0q0nQMp+McNtlUX1LbSdddyl
LuSZKeoCO90kr6K1zwnm
=ys9x
-----END PGP SIGNATURE-----

--3GGPGkJ8O0K8LB1JwcHWtrc67Pn6cHUkT--

Received: from eggs.gnu.org ([2001:4830:134:3::10]:36962)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <public@hansmi.ch>) id 1gT5ej-0008Rr-8C
	for qemu-devel@nongnu.org; Sat, 01 Dec 2018 08:50:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <public@hansmi.ch>) id 1gT5ee-0003Fv-9y
	for qemu-devel@nongnu.org; Sat, 01 Dec 2018 08:50:01 -0500
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:54847)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <public@hansmi.ch>) id 1gT5ec-0003DQ-DE
	for qemu-devel@nongnu.org; Sat, 01 Dec 2018 08:49:56 -0500
References: <20181130111222.25386-1-kraxel@redhat.com>
	<20181130111222.25386-3-kraxel@redhat.com>
	<75c973a5-f571-e69e-e2fd-72d3b3b118b2@redhat.com>
	<bfce1b7d-6b41-0296-605e-e63ed359d249@redhat.com>
	<c0da7ecd-4929-e64c-347d-a80b5368a47d@redhat.com>
From: Michael Hanselmann <public@hansmi.ch>
Message-ID: <8bbf6ad2-cd8a-fdfe-a96c-5024bd63c562@msgid.hansmi.ch>
Date: Sat, 1 Dec 2018 14:49:35 +0100
MIME-Version: 1.0
In-Reply-To: <c0da7ecd-4929-e64c-347d-a80b5368a47d@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature";
	boundary="rpjwbiMon5fvMEr3sH9Sy3DGJjuB8kDYp"
Subject: Re: [Qemu-devel] [PATCH for-3.1 2/2] usb-mtp: outlaw slashes in
 filenames
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Eric Blake <eblake@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org, Michael Hanselmann <hansmi@vshn.ch>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--rpjwbiMon5fvMEr3sH9Sy3DGJjuB8kDYp
From: Michael Hanselmann <public@hansmi.ch>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Eric Blake <eblake@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 qemu-devel@nongnu.org, Michael Hanselmann <hansmi@vshn.ch>
Message-ID: <8bbf6ad2-cd8a-fdfe-a96c-5024bd63c562@msgid.hansmi.ch>
Subject: Re: [Qemu-devel] [PATCH for-3.1 2/2] usb-mtp: outlaw slashes in
 filenames
References: <20181130111222.25386-1-kraxel@redhat.com>
 <20181130111222.25386-3-kraxel@redhat.com>
 <75c973a5-f571-e69e-e2fd-72d3b3b118b2@redhat.com>
 <bfce1b7d-6b41-0296-605e-e63ed359d249@redhat.com>
 <c0da7ecd-4929-e64c-347d-a80b5368a47d@redhat.com>
In-Reply-To: <c0da7ecd-4929-e64c-347d-a80b5368a47d@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01.12.18 12:55, Philippe Mathieu-Daud=C3=A9 wrote:
> On 30/11/18 20:58, Eric Blake wrote:
>> On 11/30/18 1:08 PM, Philippe Mathieu-Daud=C3=A9 wrote:
>>> On 30/11/18 12:12, Gerd Hoffmann wrote:
>>>> Slash is unix directory separator, so they are not allowed in filena=
mes.
>>>> Note this also stops the classic escape via "../".
>>>>
>>>> Fixes: CVE-2018-16867
>>>> Reported-by: Michael Hanselmann (hansmi.ch)
>>>
>>> It's common for scripts to match '<email>', can you write this one as=

>>> Michael Hanselmann <hansmi.ch>?
>>
>> That's not an email address, though. Do we have an email for Michael, =
or
>> just a username?
>>
>=20
> I did not notice hehe :)
>=20
> Per the gpg key: Michael Hanselmann <public@hansmi.ch>
> Per git commits: Michael Hanselmann <hansmi@vshn.ch>

It'd be <public@hansmi.ch> for this one. Thanks for asking!

Best regards,
Michael

--=20
https://hansmi.ch/


--rpjwbiMon5fvMEr3sH9Sy3DGJjuB8kDYp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEENEVC6w7lpobWh8t0Yy8zJpbbY3YFAlwCkXgACgkQYy8zJpbb
Y3alVhAAk3+3EC/zJIcA7ygrpDelAmgBD9EHw2HEcbxd7PRu2YbGt8uWRL+wm9dC
5ss9HDHIpp4+9SCZUwMoSSCcFmmYFW7rRvvN68BY5XB5A5tOV/9nP6/rOP/GPJZg
Oc1IEnrt60meL+idsiiLyVgtDPcvpzmOtnZ96e0NRwBlUZxHtb0MXDXeNvXhwSKU
x58y1GM0cQrzLkR43FOZliYxRye5zLrgE6d1bmW/1Ea3Z2LmhkCjTNB/4dz8lXyP
sWH7/TKLgStFBtrzfQ7teQsFARYNo5nMkcjtuwO4dM078X7+Uz8ivpVm4t8XjhSX
LvFEJF2qFAKrvVn3aJuDHOXA5Q2puk0v/jenbdz5HvguGkJORlB2ADsurCxvQ93y
DQffc5Vh10hM+Xn22Ri+5c68tmsOyU56Sx4szDa4+jQmGnWGT8gafv7vo+1peOfl
8VpaRe6hX1bHJAk+cipXH41Q07YFybqe/HiUFUpXD/0EWlMwPmt9CMK50tfR9Ohh
2onpvYQR7ff4GYgSw3CuWH9NWujnC+akHkJuhG5gb4VduBdAUTA0m7Bk5gaSDdWx
O85ibSMezeLZa3m7wmpdo0Z6su7ENNZ2tsBDx988zybfxKmySogMJOsXv+Vfdl6M
9Xn/BmlstvUR3IBWTVZ1J9GDBjpFt9nJiYxQr87PJrv8lLPUr8o=
=Kpfu
-----END PGP SIGNATURE-----

--rpjwbiMon5fvMEr3sH9Sy3DGJjuB8kDYp--

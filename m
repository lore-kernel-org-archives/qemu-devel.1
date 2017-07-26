Received: from eggs.gnu.org ([2001:4830:134:3::10]:48240)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1daFhd-0002JE-3H
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 02:21:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1daFha-0007Qb-02
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 02:21:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53246)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1daFhZ-0007QN-QA
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 02:21:45 -0400
References: <4E0AFA5F-44D6-4624-A99F-68A7FE52F397@meituan.com>
	<4b31a711-a52e-25d3-4a7c-1be8521097d9@redhat.com>
	<F99BFE80-FC15-40A0-BB3E-1B53B6CF9B05@meituan.com>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <859362e8-0d98-3865-8bad-a15bfa218167@redhat.com>
Date: Wed, 26 Jul 2017 09:21:38 +0300
MIME-Version: 1.0
In-Reply-To: <F99BFE80-FC15-40A0-BB3E-1B53B6CF9B05@meituan.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] =?utf-8?q?About_virtio_device_hotplug_in_Q35!_?=
 =?utf-8?b?44CQ5aSW5Z+f6YKu5Lu2LuiwqOaFjuafpemYheOAkQ==?=
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?6ZmI5Y2a?= <chenbo02@meituan.com>, alex.williamson@redhat.com, Michael Tsirkin <mst@redhat.com>
Cc: qemu-devel@nongnu.org

On 25/07/2017 11:53, =B3=C2=B2=A9 wrote:
> To accelerate data traversing between devices under the same PCIE Root=20
> Port or Switch.
>=20
> See https://lists.nongnu.org/archive/html/qemu-devel/2017-07/msg07209.h=
tml
>=20

Hi,

It may be possible, but maybe PCIe Switch assignment is not
the only way to go.

Adding Alex and Michael for their input on this matter.
More info at:
https://lists.nongnu.org/archive/html/qemu-devel/2017-07/msg07209.html

Thanks,
Marcel

>=20
> =B3=C2=B2=A9
>=20
>=20
>=20
> =D4=DA 2017=C4=EA7=D4=C224=C8=D5=A3=AC=CF=C2=CE=E77:36=A3=ACmarcel@redh=
at.com <mailto:marcel@redhat.com>=20
> =D0=B4=B5=C0=A3=BA
>=20
>> On 24/07/2017 13:24, =B3=C2=B2=A9 wrote:
>>> Is there any chance we could passthrough a real PCIE Root Port device=
=20
>>> into VM?
>>
>> Hi,
>>
>> Is an interesting thought, I didn't think about
>> it yet. What is the scenario?
>>
>> Please be sure to CC the qemu-devel next time :)
>>
>> Thanks,
>> Marcel
>>
>>> =B3=C2=B2=A9
>>
>=20

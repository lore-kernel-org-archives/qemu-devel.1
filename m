Received: from eggs.gnu.org ([2001:4830:134:3::10]:47273)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cX3oP-0005xW-R8
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 05:31:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cX3oP-0000aS-2c
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 05:31:21 -0500
References: <1485443388-27253-1-git-send-email-armbru@redhat.com>
	<1485443388-27253-2-git-send-email-armbru@redhat.com>
	<04ee1f95-988e-02f7-c1a9-f9630daf54da@redhat.com>
	<87sho59elv.fsf@dusky.pond.sub.org>
	<e84e419d-f6c4-d87b-54b5-748f34f702b6@imgtec.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <a63d1da2-c735-afa9-4a39-a188733a1782@redhat.com>
Date: Fri, 27 Jan 2017 11:31:11 +0100
MIME-Version: 1.0
In-Reply-To: <e84e419d-f6c4-d87b-54b5-748f34f702b6@imgtec.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] MIPS machines (was: [PATCH v2 1/8] hw: Default
 -drive to if=ide explicitly where it works)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yongbok Kim <yongbok.kim@imgtec.com>, Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com, =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>, Aurelien Jarno <aurelien@aurel32.net>

On 27.01.2017 11:21, Yongbok Kim wrote:
>=20
>>> Slightly off-topic, but: Is fulong2e still maintained? I did not spot=
 an
>>> entry in MAINTAINERS...?
>>
>> It's covered by the general MIPS stanza:
>>
>>     $ scripts/get_maintainer.pl -f hw/mips/mips_fulong2e.c=20
>>     Aurelien Jarno <aurelien@aurel32.net> (maintainer:MIPS)
>>     Yongbok Kim <yongbok.kim@imgtec.com> (maintainer:MIPS)
>>     qemu-devel@nongnu.org (open list:All patches CC here)
>>
>=20
> I'm not actively looking after the device at the moment but if it has a=
ny
> issues I love to handle that.

Great! Then could you maybe send a patch for the MAINTAINERS file to add
an entry for that machine?

Also it's a little bit confusing that "magnum" and "pica61" do not show
up in MAINTAINERS, but I guess that's what is meant by the "Jazz" entry?

 Thanks,
  Thomas

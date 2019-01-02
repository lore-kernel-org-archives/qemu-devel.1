Received: from eggs.gnu.org ([208.118.235.92]:48175)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fam@euphon.net>) id 1geVEo-0000Fm-Eh
	for qemu-devel@nongnu.org; Tue, 01 Jan 2019 20:22:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fam@euphon.net>) id 1geVEl-000280-8O
	for qemu-devel@nongnu.org; Tue, 01 Jan 2019 20:22:26 -0500
Received: from sender2-op-o12.zoho.com.cn ([163.53.93.243]:17332
	helo=sender1.zoho.com.cn) by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fam@euphon.net>) id 1geVEk-00024n-6i
	for qemu-devel@nongnu.org; Tue, 01 Jan 2019 20:22:23 -0500
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
From: Fam Zheng <fam@euphon.net>
In-Reply-To: <2d4a6ad2-46d8-ca16-1bf4-10ee479fa185@redhat.com>
Date: Wed, 2 Jan 2019 09:22:04 +0800
Content-Transfer-Encoding: quoted-printable
Message-Id: <989EE2A9-3D5E-4BAB-A5FA-1C3580855EF2@euphon.net>
References: <20181101183705.5422-1-philmd@redhat.com>
	<20181102064829.GB21032@magic>
	<CAAdtpL44dNQLskpUJ=33vF8Kp8jNkFYSDQXyKixvvZFUim1SUw@mail.gmail.com>
	<CAK1Eb9mWQHXY_UEfbvFvtLvM7W3vBboEQZg-mH3-J4YRodziGg@mail.gmail.com>
	<2d4a6ad2-46d8-ca16-1bf4-10ee479fa185@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] docker: Use a stable snapshot for Debian
 Sid
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Cc: =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>, =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>



> On Dec 20, 2018, at 19:20, Philippe Mathieu-Daud=C3=A9 =
<philmd@redhat.com> wrote:
>=20
> Hi Fam,
>=20
> On 11/2/18 8:24 AM, Fam Zheng wrote:
>> On Fri, Nov 2, 2018 at 3:20 PM Philippe Mathieu-Daud=C3=A9 =
<f4bug@amsat.org> wrote:
>>>=20
>>> Hi Fam,
>>>=20
>>> Thanks for picking this.
>>>=20
>>> On Fri, Nov 2, 2018 at 7:48 AM Fam Zheng <famz@redhat.com> wrote:
>>>> On Thu, 11/01 19:37, Philippe Mathieu-Daud=C3=A9 wrote:
>>>>> The Debian Sid repository is not garanteed to be stable, as his
>>>>> 'unstable' name suggest :)
>>>=20
>>> There is an error in "my be" -> "might be"...
>>> Do you mind to update the comment:
>>>=20
>>>>> To allow quick testing, packages are pushed various time a day,
>>>>> which my be annoying when trying to use it for stable development
>>>>> (which is not recommended, but Sid provides edge packages we use
>>>>> for testing).
>>>=20
>>> By:
>>>=20
>>> To allow quick testing, Debian maintainers might push packages
>>> various time a day. Sometime package dependencies might break,
>>> which is annoying when using this repository for stable development
>>> (which is not recommended, but Sid provides edge packages we use
>>> for testing).
>>=20
>> Sure, updated in my queue.
>=20
> It seems your queue never hit master=E2=80=A6
>=20

Oh.. I'll have to check out later today.

Fam

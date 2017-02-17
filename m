Received: from eggs.gnu.org ([2001:4830:134:3::10]:38186)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dmitry@daynix.com>) id 1ceac3-0007HG-4r
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 23:57:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dmitry@daynix.com>) id 1ceaby-00065H-GR
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 23:57:43 -0500
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:35398)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dmitry@daynix.com>) id 1ceaby-00064E-8l
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 23:57:38 -0500
Received: by mail-wm0-x242.google.com with SMTP id u63so613131wmu.2
	for <qemu-devel@nongnu.org>; Thu, 16 Feb 2017 20:57:38 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (1.0)
From: Dmitry Fleytman <dmitry@daynix.com>
In-Reply-To: <c661c7ed-c264-faec-00de-5c490153a665@redhat.com>
Date: Fri, 17 Feb 2017 06:57:34 +0200
Content-Transfer-Encoding: quoted-printable
Message-Id: <B3F22C53-6BB5-4DDB-9C66-0AD54285A11B@daynix.com>
References: <1487248176-29602-1-git-send-email-dmitry@daynix.com>
	<CAFEAcA-qsMk4Hbn6iNZq5cFdSWSrsWrHqP8MisMgP_yrY+Oiow@mail.gmail.com>
	<c661c7ed-c264-faec-00de-5c490153a665@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/5] A few VLAN-related bugfixes for RX
 packet abstraction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Yan Vugenfirer <yan@daynix.com>, P J P <ppandit@redhat.com>



> On 17 Feb 2017, at 5:05, Jason Wang <jasowang@redhat.com> wrote:
>=20
>=20
>=20
>> On 2017=E5=B9=B402=E6=9C=8816=E6=97=A5 20:39, Peter Maydell wrote:
>>> On 16 February 2017 at 12:29, Dmitry Fleytman <dmitry@daynix.com> wrote:=

>>> This series fix a few issues related
>>> to processing of RX packets with VLAN headers.
>>>=20
>>> See commit messages of specific patches
>>> for information regarding affected devices.
>> I think at least the "fix buffer overrun" parts of this
>> patchset should be cc:stable ?
>>=20
>> thanks
>> -- PMM
>=20
> Yes, I add cc:stable to patch 1 - 4.

Thanks, Jason!

>=20
> Thanks

Received: from eggs.gnu.org ([2001:4830:134:3::10]:51295)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1ceYrk-00081A-12
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 22:05:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1ceYrg-0006Ef-LF
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 22:05:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39846)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1ceYrg-0006Db-Et
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 22:05:44 -0500
References: <1487248176-29602-1-git-send-email-dmitry@daynix.com>
	<CAFEAcA-qsMk4Hbn6iNZq5cFdSWSrsWrHqP8MisMgP_yrY+Oiow@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <c661c7ed-c264-faec-00de-5c490153a665@redhat.com>
Date: Fri, 17 Feb 2017 11:05:39 +0800
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-qsMk4Hbn6iNZq5cFdSWSrsWrHqP8MisMgP_yrY+Oiow@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
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
To: Peter Maydell <peter.maydell@linaro.org>, Dmitry Fleytman <dmitry@daynix.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Yan Vugenfirer <yan@daynix.com>, P J P <ppandit@redhat.com>



On 2017=E5=B9=B402=E6=9C=8816=E6=97=A5 20:39, Peter Maydell wrote:
> On 16 February 2017 at 12:29, Dmitry Fleytman <dmitry@daynix.com> wrote=
:
>> This series fix a few issues related
>> to processing of RX packets with VLAN headers.
>>
>> See commit messages of specific patches
>> for information regarding affected devices.
> I think at least the "fix buffer overrun" parts of this
> patchset should be cc:stable ?
>
> thanks
> -- PMM

Yes, I add cc:stable to patch 1 - 4.

Thanks

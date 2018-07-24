Received: from eggs.gnu.org ([2001:4830:134:3::10]:37596)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fi3OZ-0003bo-1d
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 15:54:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fi3OY-0006h5-CU
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 15:54:55 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:40773)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fi3OY-0006gU-6E
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 15:54:54 -0400
Received: by mail-oi0-x243.google.com with SMTP id w126-v6so9736323oie.7
	for <qemu-devel@nongnu.org>; Tue, 24 Jul 2018 12:54:54 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <2b1ef4d8-c938-0e3c-2d6a-933fb1e309f7@redhat.com>
References: <20180724142504.15092-1-stefanha@redhat.com>
	<2b1ef4d8-c938-0e3c-2d6a-933fb1e309f7@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 24 Jul 2018 20:54:32 +0100
Message-ID: <CAFEAcA_7q9Z80iO4R2mA1VGwSO=BgJNSrrhCNppct0iiQzT_LA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL for-3.0 0/1] Tracing patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On 24 July 2018 at 16:13, Eric Blake <eblake@redhat.com> wrote:
> On 07/24/2018 09:25 AM, Stefan Hajnoczi wrote:
>>
>> The following changes since commit
>> 768cef2974fb1fa30dd188b043ea737e13fea477:
>>
>>    Merge remote-tracking branch
>> 'remotes/ehabkost/tags/x86-next-pull-request' into staging (2018-07-24
>> 10:37:52 +0100)
>>
>> are available in the Git repository at:
>>
>>    git://github.com/stefanha/qemu.git tags/tracing-pull-request
>>
>> for you to fetch changes up to b6ad6a528f2356b357bd1d210048dd7988dc9a7b:
>>
>>    trace/simple: fix hang in child after fork(2) (2018-07-24 14:27:51
>> +0100)
>>
>> ----------------------------------------------------------------
>> Pull request
>>
>> Fix qemu-iotests 147 when QEMU was built with ./configure
>> --enable-trace-backend=simple.
>
>
> Design conversation ongoing under patch 1/1 - replying here to make sure
> this doesn't get applied if we aren't ready for it yet.

OK; I'll drop this pullreq from my queue. Pleas ping me again if
the outcome is that it should be applied.

thanks
-- PMM

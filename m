Received: from eggs.gnu.org ([2001:4830:134:3::10]:35709)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fLnM3-000099-Oz
	for qemu-devel@nongnu.org; Thu, 24 May 2018 06:20:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fLnLz-0007GR-5M
	for qemu-devel@nongnu.org; Thu, 24 May 2018 06:20:19 -0400
Received: from mail-ot0-x242.google.com ([2607:f8b0:4003:c0f::242]:42973)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fLnLz-0007FS-11
	for qemu-devel@nongnu.org; Thu, 24 May 2018 06:20:15 -0400
Received: by mail-ot0-x242.google.com with SMTP id l13-v6so1270733otk.9
	for <qemu-devel@nongnu.org>; Thu, 24 May 2018 03:20:14 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <0eb5c40aa1e08b7c07706a08c3dc173a@walle.cc>
References: <20180521154952.15421-1-michael@walle.cc>
	<CAFEAcA_9Cj0smiup_-gCf_QFbyt-kJDEykFMYJ-KMeand9dyWg@mail.gmail.com>
	<0eb5c40aa1e08b7c07706a08c3dc173a@walle.cc>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 24 May 2018 11:19:53 +0100
Message-ID: <CAFEAcA8if3VpLqjZnx4zNOv=GnBzpSDxu-pLfs-h3qTt74UyVA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/1] target/lm32 BQL patch
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Walle <michael@walle.cc>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 22 May 2018 at 19:33, Michael Walle <michael@walle.cc> wrote:
> Am 2018-05-22 12:01, schrieb Peter Maydell:
>>
>> On 21 May 2018 at 16:49, Michael Walle <michael@walle.cc> wrote:
>>>
>>> The following changes since commit
>>> 81e9cbd0ca1131012b058df6804b1f626a6b730c:
>>>
>>>   lm32: take BQL before writing IP/IM register (2018-05-21 13:37:12
>>> +0200)
>>>
>>> are available in the git repository at:
>>>
>>>   git://github.com/mwalle/qemu.git tags/lm32-queue/20180521
>>
>>
>> Hi -- this doesn't appear to be a GPG signed tag?
>>
>
> whoops, fixed. I guess I get everything wrong with this patch/pullrequest..

Applied the now-signed version.

thanks
-- PMM

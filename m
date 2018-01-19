Received: from eggs.gnu.org ([2001:4830:134:3::10]:35241)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ecXgV-0007nY-9d
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 09:30:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ecXgR-0000Ib-46
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 09:30:23 -0500
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:32874)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ecXgQ-0000IP-V8
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 09:30:19 -0500
Received: by mail-oi0-x244.google.com with SMTP id y141so1229781oia.0
	for <qemu-devel@nongnu.org>; Fri, 19 Jan 2018 06:30:18 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <595f00e6-d5ad-b7c6-29be-7c6e135f9d12@redhat.com>
References: <20180117144756.31049-1-marcandre.lureau@redhat.com>
	<595f00e6-d5ad-b7c6-29be-7c6e135f9d12@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 19 Jan 2018 14:29:57 +0000
Message-ID: <CAFEAcA_M7FazuMDpne5Fr=hQUmfp75BHqttYOWV+HJ9zinW6mA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 0/1] Dump patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On 17 January 2018 at 15:02, Eric Blake <eblake@redhat.com> wrote:
> On 01/17/2018 08:47 AM, Marc-Andr=C3=A9 Lureau wrote:
>> The following changes since commit 8e5dc9ba49743b46d955ec7dacb04e42ae7ad=
a7c:
>>
>>   Merge remote-tracking branch 'remotes/rth/tags/pull-tcg-20180116' into=
 staging (2018-01-16 17:36:39 +0000)
>>
>> are available in the Git repository at:
>>
>>   https://github.com/elmarco/qemu.git tags/dump-pull-request
>>
>> for you to fetch changes up to 48fb74965a8d8f2916da30d9c5b9945df25142af:
>>
>>   dump-guest-memory.py: fix python 2 support (2018-01-17 15:47:14 +0100)
>>
>
> The commit says it works with python 2.7, but we still require support
> for python 2.6.  Is this pull request premature?

So should I apply this, or not?

thanks
-- PMM

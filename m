Received: from eggs.gnu.org ([2001:4830:134:3::10]:55520)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cYBWf-0004wU-1i
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 07:57:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cYBWe-0002sN-C6
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 07:57:41 -0500
Received: from mail-ua0-x22f.google.com ([2607:f8b0:400c:c08::22f]:34516)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cYBWe-0002sH-8L
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 07:57:40 -0500
Received: by mail-ua0-x22f.google.com with SMTP id 35so249094333uak.1
	for <qemu-devel@nongnu.org>; Mon, 30 Jan 2017 04:57:40 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <8d16a464-18c0-feb6-d1dd-1a9e3d8c84aa@redhat.com>
References: <20170127193504.32290-1-pbonzini@redhat.com>
	<8d16a464-18c0-feb6-d1dd-1a9e3d8c84aa@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 30 Jan 2017 12:57:19 +0000
Message-ID: <CAFEAcA9a-eybevVZ2ad3tTD7FfJvUp_eShSx65h8XUtKAUyUEA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL v2 00/41] Misc patches for 2017-01-27
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On 30 January 2017 at 12:33, Laszlo Ersek <lersek@redhat.com> wrote:
> Peter,
>
> On 01/27/17 20:35, Paolo Bonzini wrote:
>> The following changes since commit 29ba0cdc1fd1300f910d150c03a0f74236083bf7:
>>
>>   Merge remote-tracking branch 'remotes/armbru/tags/pull-qapi-2017-01-27' into staging (2017-01-27 15:20:08 +0000)
>>
>> are available in the git repository at:
>>
>>   git://github.com/bonzini/qemu.git tags/for-upstream
>>
>> for you to fetch changes up to 6da67de6803e93cbb7e93ac3497865832f8c00ea:
>>
>>   memory: don't sign-extend 32-bit writes (2017-01-27 18:08:00 +0100)
>>
>
> Can you please pull this v2?

I am currently processing it, yes. Paolo only sent it to the list
late on Friday evening, and I don't generally work weekends,
so it's not like this has been lying around for a long time...

thanks
-- PMM

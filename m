Received: from eggs.gnu.org ([2001:4830:134:3::10]:59425)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gAl3j-0002EZ-G8
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 20:12:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gAl3g-00018y-0j
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 20:12:03 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a]:44992)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@sifive.com>) id 1gAl3f-00018J-IW
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 20:11:59 -0400
Received: by mail-pg1-x52a.google.com with SMTP id g2-v6so4927408pgu.11
	for <qemu-devel@nongnu.org>; Thu, 11 Oct 2018 17:11:58 -0700 (PDT)
Date: Thu, 11 Oct 2018 17:11:56 -0700 (PDT)
In-Reply-To: <CAFEAcA_-f905hV39yhVypBQzTfocEOPsFvNGK0a=KBm+cKfRCQ@mail.gmail.com>
From: Palmer Dabbelt <palmer@sifive.com>
Message-ID: <mhng-2e15f6c1-6af6-41a4-acbe-eb90d77dac25@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v1 0/5] Misc RISC-V patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: Alistair.Francis@wdc.com, alistair23@gmail.com, Michael Clark <mjc@sifive.com>, qemu-devel@nongnu.org

On Thu, 11 Oct 2018 02:34:16 PDT (-0700), peter.maydell@linaro.org wrote:
> On 10 October 2018 at 19:22, Palmer Dabbelt <palmer@sifive.com> wrote:
>> On Wed, 10 Oct 2018 11:10:07 PDT (-0700), peter.maydell@linaro.org wrote:
>>>
>>> On 10 October 2018 at 18:49, Palmer Dabbelt <palmer@sifive.com> wrote:
>>>>
>>>> we should really
>>>> get the ball rolling on our big patch backlog.
>>>
>>>
>>> Yes, please do. Softfreeze is not all that far away and I
>>> would strongly prefer not to get an enormous sized pull
>>> request at the last minute. The ideal pattern is that
>>> code changes come in at a steady rate across the whole
>>> of the 'open' part of the development cycle.
>>
>>
>> Ya, sorry, we've been a bit out of it.  If I understand correctly, the soft
>> freeze is the 30th?  If so it's really time to get started, and it looks
>> like Michael is busy so I'll have to go figure this out.
>
> Alistair's done the last couple of riscv pullrequests, so it might
> be simpler if he keeps doing that, but I'll let you sort that out
> between yourselves.

Ah, great.  I'm always happy to have other people do things, I just feel kind 
of bad: I'm a maintainer and I'm putting the burden on someone else to submit a 
PR.

If Alistair is happy submitting PRs than I'm happy to have him do it :).

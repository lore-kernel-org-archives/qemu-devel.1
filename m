Received: from eggs.gnu.org ([2001:4830:134:3::10]:55022)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gAXMd-0003Hx-17
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 05:34:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gAXMc-0005mr-B8
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 05:34:38 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:45228)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gAXMc-0005mC-4w
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 05:34:38 -0400
Received: by mail-ot1-x341.google.com with SMTP id u22so8232859ota.12
	for <qemu-devel@nongnu.org>; Thu, 11 Oct 2018 02:34:38 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <mhng-e2fff6d4-8420-48c5-92d9-cc03e16dfa48@palmer-si-x1c4>
References: <CAFEAcA_fmoBRTk0VKEjuu82eb7piCkq588+v7RT7r6f=_4=OVw@mail.gmail.com>
	<mhng-e2fff6d4-8420-48c5-92d9-cc03e16dfa48@palmer-si-x1c4>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 11 Oct 2018 10:34:16 +0100
Message-ID: <CAFEAcA_-f905hV39yhVypBQzTfocEOPsFvNGK0a=KBm+cKfRCQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v1 0/5] Misc RISC-V patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Palmer Dabbelt <palmer@sifive.com>
Cc: Alistair Francis <Alistair.Francis@wdc.com>, Alistair Francis <alistair23@gmail.com>, Michael Clark <mjc@sifive.com>, QEMU Developers <qemu-devel@nongnu.org>

On 10 October 2018 at 19:22, Palmer Dabbelt <palmer@sifive.com> wrote:
> On Wed, 10 Oct 2018 11:10:07 PDT (-0700), peter.maydell@linaro.org wrote:
>>
>> On 10 October 2018 at 18:49, Palmer Dabbelt <palmer@sifive.com> wrote:
>>>
>>> we should really
>>> get the ball rolling on our big patch backlog.
>>
>>
>> Yes, please do. Softfreeze is not all that far away and I
>> would strongly prefer not to get an enormous sized pull
>> request at the last minute. The ideal pattern is that
>> code changes come in at a steady rate across the whole
>> of the 'open' part of the development cycle.
>
>
> Ya, sorry, we've been a bit out of it.  If I understand correctly, the soft
> freeze is the 30th?  If so it's really time to get started, and it looks
> like Michael is busy so I'll have to go figure this out.

Alistair's done the last couple of riscv pullrequests, so it might
be simpler if he keeps doing that, but I'll let you sort that out
between yourselves.

thanks
-- PMM

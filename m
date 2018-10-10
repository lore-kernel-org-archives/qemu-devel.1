Received: from eggs.gnu.org ([2001:4830:134:3::10]:58249)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1gAJ03-0006aN-4k
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 14:14:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1gAIzy-0005To-09
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 14:14:23 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:39010)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1gAIzx-0005TL-Lr
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 14:14:17 -0400
Received: by mail-pf1-x443.google.com with SMTP id c25-v6so3033665pfe.6
	for <qemu-devel@nongnu.org>; Wed, 10 Oct 2018 11:14:17 -0700 (PDT)
References: <cover.1539023064.git.alistair.francis@wdc.com>
	<mhng-99c18a25-be61-4fa6-93c6-313a0fa37372@palmer-si-x1c4>
	<CAFEAcA_fmoBRTk0VKEjuu82eb7piCkq588+v7RT7r6f=_4=OVw@mail.gmail.com>
From: Alistair <alistair23@gmail.com>
Message-ID: <b731830c-54c5-8ce2-462e-075188521fed@gmail.com>
Date: Wed, 10 Oct 2018 11:14:13 -0700
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_fmoBRTk0VKEjuu82eb7piCkq588+v7RT7r6f=_4=OVw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 0/5] Misc RISC-V patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Palmer Dabbelt <palmer@sifive.com>
Cc: Alistair Francis <Alistair.Francis@wdc.com>, Michael Clark <mjc@sifive.com>, QEMU Developers <qemu-devel@nongnu.org>



On 10/10/2018 11:10 AM, Peter Maydell wrote:
> On 10 October 2018 at 18:49, Palmer Dabbelt <palmer@sifive.com> wrote:
>> we should really
>> get the ball rolling on our big patch backlog.
> 
> Yes, please do. Softfreeze is not all that far away and I
> would strongly prefer not to get an enormous sized pull
> request at the last minute. The ideal pattern is that
> code changes come in at a steady rate across the whole
> of the 'open' part of the development cycle.

Understandable. I'll send a PR in the next few days. I'm hoping I can 
bundle it with my PCIe patches which are just waiting on some discussion.

Alistair

> 
> thanks
> -- PMM
> 

Received: from eggs.gnu.org ([209.51.188.92]:53576)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gtwYK-000547-4v
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 10:34:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gtwYJ-00068L-DU
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 10:34:24 -0500
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:33699)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@sifive.com>) id 1gtwYJ-00067N-5n
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 10:34:23 -0500
Received: by mail-pg1-x541.google.com with SMTP id z11so1300848pgu.0
	for <qemu-devel@nongnu.org>; Wed, 13 Feb 2019 07:34:22 -0800 (PST)
Date: Wed, 13 Feb 2019 07:34:19 -0800 (PST)
In-Reply-To: <7a7b5675-3d66-6c87-8830-74c60f8a7471@mail.uni-paderborn.de>
From: Palmer Dabbelt <palmer@sifive.com>
Message-ID: <mhng-64897fe3-6dad-4973-9246-07c07ecba2af@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v6 00/35] target/riscv: Convert to
 decodetree
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Cc: richard.henderson@linaro.org, peer.adelt@hni.uni-paderborn.de, qemu-riscv@nongnu.org, qemu-devel@nongnu.org, sagark@eecs.berkeley.edu

On Wed, 13 Feb 2019 01:06:41 PST (-0800), Bastian Koppelmann wrote:
>
> On 2/13/19 3:15 AM, Palmer Dabbelt wrote:
>> On Tue, Feb 12, 2019 at 3:21 PM Palmer Dabbelt <palmer@sifive.com> wrote:
> [snip]
>>>
>>> Do you, by any chance, have a v7?  It looks like there's quite a few merge
>>> conflicts here, and while I'm OK fixing them I don't want to do it if you
>>> already have.
>>>
>> I made it through my rebase, so unless you want to send out a v7 I will.
>> There were some meaningful changes so I'd like to get a round of review
>> just so everyone is on the same page.
>
>
> Thanks for doing this work. I don't have a v7 yet, since I was waiting
> on your current pull-request to get merged. So please do send a v7, I'm
> happy to review/test it.

Sounds good.  It definitely deserves a review, as I was sort of just fumbling 
around in the dark here :)

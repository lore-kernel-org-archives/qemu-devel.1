Received: from eggs.gnu.org ([209.51.188.92]:55872)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1gtqVG-0007Jv-LS
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 04:06:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1gtqVF-0000pM-VM
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 04:06:50 -0500
References: <20190123092538.8004-1-kbastian@mail.uni-paderborn.de>
	<mhng-0fc7cd00-deda-4e41-abb3-c78657c4f0f1@palmer-si-x1c4>
	<CANs6eMkMKGKVdnWh2CmEz1sOtXEZh6eMUN5NkCwGjna7zEhh9Q@mail.gmail.com>
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Message-ID: <7a7b5675-3d66-6c87-8830-74c60f8a7471@mail.uni-paderborn.de>
Date: Wed, 13 Feb 2019 10:06:41 +0100
MIME-Version: 1.0
In-Reply-To: <CANs6eMkMKGKVdnWh2CmEz1sOtXEZh6eMUN5NkCwGjna7zEhh9Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US-large
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
To: Palmer Dabbelt <palmer@sifive.com>
Cc: richard.henderson@linaro.org, peer.adelt@hni.uni-paderborn.de, qemu-riscv@nongnu.org, qemu-devel@nongnu.org, Sagar Karandikar <sagark@eecs.berkeley.edu>


On 2/13/19 3:15 AM, Palmer Dabbelt wrote:
> On Tue, Feb 12, 2019 at 3:21 PM Palmer Dabbelt <palmer@sifive.com> wrote:
[snip]
>>
>> Do you, by any chance, have a v7?  It looks like there's quite a few merge
>> conflicts here, and while I'm OK fixing them I don't want to do it if you
>> already have.
>>
> I made it through my rebase, so unless you want to send out a v7 I will.
> There were some meaningful changes so I'd like to get a round of review
> just so everyone is on the same page.


Thanks for doing this work. I don't have a v7 yet, since I was waiting 
on your current pull-request to get merged. So please do send a v7, I'm 
happy to review/test it.

Cheers,

Bastian

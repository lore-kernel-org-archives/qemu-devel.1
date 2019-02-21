Received: from eggs.gnu.org ([209.51.188.92]:60937)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gws4m-0006EG-MU
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 12:24:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gws4m-0003EC-1o
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 12:24:00 -0500
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:39296)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@sifive.com>) id 1gws4k-0003D2-Oz
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 12:23:59 -0500
Received: by mail-pg1-x541.google.com with SMTP id r11so14009035pgp.6
	for <qemu-devel@nongnu.org>; Thu, 21 Feb 2019 09:23:57 -0800 (PST)
Date: Thu, 21 Feb 2019 09:23:55 -0800 (PST)
In-Reply-To: <7cf246c6-1bb7-6479-7448-750a9f9801e0@mail.uni-paderborn.de>
From: Palmer Dabbelt <palmer@sifive.com>
Message-ID: <mhng-70a0b021-43a4-4faa-9692-bdda93805b30@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v7 00/35] target/riscv: Convert to
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
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org

On Wed, 20 Feb 2019 09:02:57 PST (-0800), Bastian Koppelmann wrote:
> Hi Palmer,
>
> On 2/13/19 4:53 PM, Palmer Dabbelt wrote:
>> Palmer: I caused some merge conflicts in Bastian's patch set so I
>> figured I'd attempt to clean these up.  As far as I'm concerned v6 was
>> good to go, but since the merge conflicts were fairly extensive (if
>> somewhat mechanical) I'd like to pass the baton back to Bastian here for
>> at least a sanity check.
>
>
> Thanks for doing the merge. I will have time on Friday to integrate my
> nitpicks and send a v8. Then it should be good to be merged.

Great, thanks!  I haven't gotten a chance to look, but I want to get this in 
before anything else so we don't end up with a bunch of conflicts again :)

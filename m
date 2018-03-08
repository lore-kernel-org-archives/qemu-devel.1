Received: from eggs.gnu.org ([2001:4830:134:3::10]:38194)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1eu1ID-0001Ms-LB
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 14:34:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1eu1Ea-0007yC-Fl
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 14:33:33 -0500
Received: from mail-pf0-x22f.google.com ([2607:f8b0:400e:c00::22f]:36281)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@sifive.com>) id 1eu1Ea-0007wU-2i
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 14:29:48 -0500
Received: by mail-pf0-x22f.google.com with SMTP id 68so306099pfx.3
	for <qemu-devel@nongnu.org>; Thu, 08 Mar 2018 11:29:46 -0800 (PST)
Date: Thu, 08 Mar 2018 11:29:44 -0800 (PST)
In-Reply-To: <CAHNT7NshwZh87Uui6i+ARdOj2BuW6d7gahOiZ0X48Cf3TdOrXQ@mail.gmail.com>
From: Palmer Dabbelt <palmer@sifive.com>
Message-ID: <mhng-91cb2b22-0b57-4c9b-8027-8c25eba32497@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [patches] Re: [PULL] RISC-V QEMU Port Submission
 v8.2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Clark <mjc@sifive.com>, peter.maydell@linaro.org
Cc: kbastian@mail.uni-paderborn.de, qemu-devel@nongnu.org, patches@groups.riscv.org, sagark@eecs.berkeley.edu

On Thu, 08 Mar 2018 03:41:33 PST (-0800), Michael Clark wrote:
> On Fri, 9 Mar 2018 at 12:18 AM, Michael Clark <mjc@sifive.com> wrote:
>> On Fri, 9 Mar 2018 at 12:10 AM, Michael Clark <mjc@sifive.com> wrote:
>>> On Thu, 8 Mar 2018 at 11:02 PM, Peter Maydell <peter.maydell@linaro.org>
>>> wrote:
>>>> On 6 March 2018 at 19:46, Michael Clark <mjc@sifive.com> wrote:
>> You are making this very hard. Do you work for Arm perchance? I really
>> wouldn’t be surprised if our port is being sandbagged by Arm. Apologies for
>> being so direct about this, but things like this happen...
>>
>> I have complied with practically every review request and the sign-offs
>> are there. It’s a bit ridiculous.
>>
>> It would be nice to find someone neutral, unrelated to Arm, to merge our PR
>>
>
> Some history on the origins of RISC to put things in perspective:
>
> https://en.m.wikipedia.org/wiki/Berkeley_RISC
>
> David Patterson worked with Andrew Waterman and Krste Asanovic on the
> design of RISC-V. Sagar did most of the work on the QEMU port and he
> agreeded to sign off on all patches. The SiFive patches only have sign-offs
> from SiFive because SiFive was the sole contributor for its hardware model,
> beside the SiFiveUART which has Stefan’s sign-off.
>
> In any case it seems there is not enough review bandwidth in the QEMU
> project as a whole and the policy to accept contributions is too strict to
> be reasonable, given earnest attempts to comply with *all* review feedback.
> Not impressed.

On behalf of the rest of the RISC-V QEMU team I'd like to apologize for 
Michael's comments.  That's a pretty insulting thing to say, and the whole 
thing comes off as a bit entitled: we've asked the QEMU community to do a lot 
of work for us in reviewing our port, and seeing as how none of us are QEMU 
contributors we certainly don't have any grounds to ask someone to stop 
reviewing it -- that's pretty absurd.

While I haven't been following the upstreaming process as closely as I should 
have been, as far as I can tell there's no grounds to accuse Peter, or anyone 
else, of trying to shoot down our port for any reason.  Peter, I can understand 
if you're upset, as I certainly would be.  If you don't want to help out with 
our port any more then I can understand, but I'd just like to assure you that 
we value the time you've spent on our port and hope you continue to help out!

Hopefully this doesn't derail our chances of moving forward with submitting the 
RISC-V port upstream.

Sorry!

Received: from eggs.gnu.org ([209.51.188.92]:39037)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gn9rV-00071D-6Y
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 17:22:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gn9rT-0001U7-6u
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 17:22:08 -0500
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:39674)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@sifive.com>) id 1gn9rQ-00019w-QL
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 17:22:07 -0500
Received: by mail-pf1-x441.google.com with SMTP id r136so5366878pfc.6
	for <qemu-devel@nongnu.org>; Fri, 25 Jan 2019 14:21:31 -0800 (PST)
Date: Fri, 25 Jan 2019 14:21:28 -0800 (PST)
In-Reply-To: <20190119002957.9794-1-michaeljclark@mac.com>
From: Palmer Dabbelt <palmer@sifive.com>
Message-ID: <mhng-389c7b9e-6a81-4ad8-a53b-3d9c585794ca@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v1] GLib sucks - Remove any connections
 between me and GLib
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-devel@nongnu.org, Michael Clark <michaeljclark@mac.com>, Alistair Francis <Alistair.Francis@wdc.com>

On Fri, 18 Jan 2019 16:29:57 PST (-0800), Michael Clark wrote:
> One has a basic command of English but one cannot think of a
> more or less glib commit message for this commit so this is it.
>
> Palmer, I would like to send you an invoice for this commit
> but I do not know what value to place on it. 2^64-1, (-1)
> or 0xFFFFFFFFFFFFFFFF in hex, sounds too little or too much.
>
> You also will have to pay better for me to use nicer language,
> and you can bet your bottom dollar it won’t be C. Also, as we
> discussed, having one’s direct competitors in control of our
> emulation infrastructure is not a great idea. I thought we
> agreed on that then I find out we are in disagreement.
>
> However, I feel comfortable because, while I haven’t been paid
> since last August, I am arranging temporary support with
> WINZ <https://www.workandincome.govt.nz/>, however, one must
> note, that when one’s work is sabotaged in the real world,
> folk end up without jobs, whereas if we were just a student
> then we probably only end up with a bruised ego and perhaps
> lower grades if our supervisor is not happy. In the real world,
> we get the shit scared out of us because we think we could be
> fired at any moment. i.e. zero-day. I think because I dropped
> out of school, I never learned that. Anyhow, I didn’t read
> the contract. I just wanted to get a paycheck so I could play
> games with folk on the Internet. That’s bullshit. I wasn’t
> playing games, now I am. I was released from a mental ward
> after a severe episode of anxiety and depression. True Story.
> Anyway Palmer fired me today. Performance issues I suspect.
> Could be trust, security, mistakes or simply misalignment on
> basic issues. Haven't had post-mortem yet.
>
> BTW What if we auctioned commits and if your commit didn’t
> get in, you don’t get paid. Commits would become expensive?
> (or cheap?). 🤔
>
> Also, do we have MIA and KIA tags for MAINTAINERS? We could
> even put little Unicode medals next to titles like this:
>
>    (sub³)∘maintainer 🎖🎖️  A. Nonymous
>
> What is the operator binding precedence? i.e. do we that need
> parenthesis there or does exponentiation bind more tightly
> than the ring operator?
>
> Otherwise, please just delete me. It’s bad memories all round.
> as I got fired today because of my QEMU performance. I am a
> terrible mess when using version control.
>
> Maybe when I have a secure job we can meet up for a beer and
> everything will be okay, but at this point we have the wolves
> at the door and are worried about an imminent eviction by the
> landlord. Also true story (the conditions of port submission).
>
> I know a lot of you are going to say, send me back to the
> mental ward, however, I will miss my partner/spouse. We were
> actually looking for a house in Palmerston North over the
> weekend in preparation for my imminent demise (she still thinks
> we can afford to live here in Auckland and everything is fine),
> as we thought it would be survivable on social security, however,
> I suspect she may not support me any more given the number of
> jobs I have lost in the past 6 years since we met. Indeed, rv8
> was written mostly on a benefit from the Ministry of Social
> Development, C/- New Zealand Government. Oesensibly Job Seeker
> Support, but we were searching for a job that didn’t have too
> many interruppts, and then SiFive put me to work on a bloody
> interrupt controller. That’s ironic. Of course I am slow and
> cannot multitask so QEMU queue management was neglected.
>
> Note: the auction reserve on this commit is ten bucks, or
> alternatively, /almost/ the price of a beer in Singapore,
> so someone will need to top it up. i.e. free as in /almost/
> free beer.
>
> P.S. Don’t mess with the RISC-V Virtual Machine Model without
> consulting RISC-V SW Dev list or RISC-V ISA Dev list or the
> closed doors working groups in the RISC-V Foundation. Personally
> I prefer open discussion. Also, it is not the QEMU virt machine,
> it is the RISC-V virt machine because SiFive has a VirtIO model
> on Amazon F1, so if you mess with it in QEMU you’ll break prod.
>
> P.P.S. No offence to the GLib maintainers, but automatic
> reference counting or garbage collection is much safer to
> use in higher level code that does user interaction. We could
> get all sorts of leaks and what not. As you know I missed free
> (or g_free, although you know what I mean).
>
> P.P.P.S I do not represent my employer because I just got
> fired today. Anyone know of any jobs going for a crusty old C++
> developer who prefers std::unique_ptr<T[]> over malloc/free?
>
> P.P.P.P.S Is firecracker written in C++? Rust I think dammit,
> maybe I should learn Rust. Don’t worry I know nobody likes me,
> so it won’t help me no matter how much I learn. I will still
> be an overweight middle-aged (human) with no sense of humour
> and a fond affection for C+.
>
> P.P.P.P.P.S I’m not trying to rub it in (I lied, I am).
>
> If you are curious about my alter-ego, it’s my (older) brother,
> he’s clever, and I am the dumb one with no sense of humour.
> I was trying to get a job in California by writing cloud apps
> and he somehow ends up in Walnut Creek. Yes, FreeBSD user
> apparently. We had a very long fight over what OS to use as
> a firewall (in a school of all places) and FreeBSD won apparently
> i.e. `ipfw`. I was a Linux user with an IBM ThinkPad and he was
> a macOS X user with a Titanium macbook. BTW Age is not really an
> asset unless you have a secure job as a gatekeeper somewhere.
> I guess here, in QEMU-land, performance is number of merged PRs,
> ideally nicely batched along with lots of testing, and not just
> regressions; also performance.
>
> And if you think this commit is staged, then you are wrong.
> Committed, but to where I do not know (my personal repository,
> hopefully not a mental institution). Also, apologies to my
> brother for mentioning him here, but when the person who does
> your AR/AP and payroll quits, and one is supposedly a charity
> case, then they can do quite a lot of damage. He is the high
> flighing wealthy expat with all the perks, including dental
> and I am looking at the Dole queue. Of course he has to work
> with morons. I'll only work with nice people, so life is hard.
>
> Our old website is still up and running, so if anyone wants
> firewalls, storage, security, compute; then my brother knows
> how to do that and I can do C++ apps for iOS, android, macOS,
> Windows, Linux and now bare metal (ideally something easier
> than using git or dealing with people which I suck at):
>
> - https://www.metaparadigm.com/
>
> You can pull my changes from my personal repo here:
>
> - https://github.com/michaeljclark/riscv-qemu/tree/qemu-mjc
>
> Apologies for the noise! and sorry for bringing GLib into
> this dispute between me and Palmer. 🙃

I don't think this is really appropriate for a commit message, so I'll submit 
another one.

> Cc: Palmer Dabbelt <palmer@sifive.com>
> Cc: Alistair Francis <Alistair.Francis@wdc.com>
> Signed-off-by: Michael Clark <michaeljclark@mac.com>
> ---
>  MAINTAINERS | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index af339b86db76..47cb3c14298e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -259,7 +259,6 @@ F: include/hw/ppc/
>  F: disas/ppc.c
>
>  RISC-V
> -M: Michael Clark <mjc@sifive.com>
>  M: Palmer Dabbelt <palmer@sifive.com>
>  M: Alistair Francis <Alistair.Francis@wdc.com>
>  M: Sagar Karandikar <sagark@eecs.berkeley.edu>

Sorry to see you go!

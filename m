Received: from eggs.gnu.org ([2001:4830:134:3::10]:51151)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eqkGk-0006Ly-I1
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 13:46:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eqkGj-0002We-Jq
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 13:46:30 -0500
Received: from mail-ot0-x235.google.com ([2607:f8b0:4003:c0f::235]:37675)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eqkGj-0002W2-EX
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 13:46:29 -0500
Received: by mail-ot0-x235.google.com with SMTP id t2so4760835otj.4
	for <qemu-devel@nongnu.org>; Tue, 27 Feb 2018 10:46:29 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_hQAYFqDeLrzfXSdvZgM0C_U1FVMZ4xUx7ArT=OwA5DQ@mail.gmail.com>
References: <CAFEAcA9qyg-J5UcGZu5XJyUnn799-V4HXSGfyCYNYE9_eK-a0Q@mail.gmail.com>
	<CAFEAcA_hQAYFqDeLrzfXSdvZgM0C_U1FVMZ4xUx7ArT=OwA5DQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 27 Feb 2018 18:46:07 +0000
Message-ID: <CAFEAcA_dhsC8BKHzdW5cHhYot8s3vdAOvmys7HACSZJ6ZP=vDw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] proposed release schedule for QEMU 2.12
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>

On 23 February 2018 at 16:04, Peter Maydell <peter.maydell@linaro.org> wrote:
> On 30 January 2018 at 16:25, Peter Maydell <peter.maydell@linaro.org> wrote:
>> It seems like it's about time we settled on the dates for the
>> 2.12 release. I've sketched in a suggestion at:
>>   https://wiki.qemu.org/Planning/2.12
>>
>> which puts softfreeze on the 13th March, hardfreeze a
>> week later on the 20th, and final release on the 17th April.
>>
>> (I basically just took last year's spring release
>> schedule; suggestions for adjustments welcome.
>> Easter is the weekend of the 1st April so will fall
>> between rc1 and rc2.)
>
> Ping! Any objections to this schedule or shall we go with it?
> (softfreeze would be in just over 2 weeks from now)

Nobody complained, so I've updated the wiki page to say this is
the final schedule. Softfreeze now in exactly 2 weeks.

thanks
-- PMM

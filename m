Received: from eggs.gnu.org ([2001:4830:134:3::10]:59250)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dUZV6-0003cb-Tu
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 10:17:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dUZV3-0000nD-NA
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 10:17:24 -0400
Received: from mail-lf0-x22c.google.com ([2a00:1450:4010:c07::22c]:36273)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dUZV3-0000mi-Dj
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 10:17:21 -0400
Received: by mail-lf0-x22c.google.com with SMTP id h22so62283515lfk.3
	for <qemu-devel@nongnu.org>; Mon, 10 Jul 2017 07:17:21 -0700 (PDT)
References: <20170621144814.15324-1-alex.bennee@linaro.org>
	<CAFEAcA91jcDezunfEKwB+DBdzrEAFYWHKRyFmPyCNYSs_4N4JA@mail.gmail.com>
	<6152fff6-f4db-b0c2-bf20-181364544412@amsat.org>
	<87wp84rr6h.fsf@linaro.org>
	<CAAdtpL6tLfG1dUO8nmGvb2vAtX-OTkoFKWQt=MdxUULyonE8AA@mail.gmail.com>
	<CAAdtpL7kaQSm_Kbn+DrD9Kkzj3JH47pM+-RxXYB=_fyEb+7NxQ@mail.gmail.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <CAAdtpL7kaQSm_Kbn+DrD9Kkzj3JH47pM+-RxXYB=_fyEb+7NxQ@mail.gmail.com>
Date: Mon, 10 Jul 2017 15:17:17 +0100
Message-ID: <87r2xo9y1e.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PULL 00/21] Docker and shippable updates
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: Fam Zheng <famz@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>


Philippe Mathieu-Daudé <f4bug@amsat.org> writes:

> On Thu, Jun 22, 2017 at 12:42 PM, Philippe Mathieu-Daudé
> <f4bug@amsat.org> wrote:
>> On Thu, Jun 22, 2017 at 12:13 PM, Alex Bennée <alex.bennee@linaro.org> wrote:
>>> Now we've been running shippable for a while is it worth turning on the
>>> IRC notifications?
>>
>> What about moving such bot/scripts notifications in another channel
>> like #QEMU-notifications?
>
> ping?

I'm in two minds so I suspect this is something that needs to be taken
to the users of #qemu.

>> It is often hard to follow 3 concurrent topics while the travis-ci bot
>> disrupts entering/broadcasting/leaving...

I find it useful as its somewhere I look at a lot. That said it is not
exactly a trial to sub to yet another IRC channel.

>> I'd also like to see here checkpatch/patchew stripped output, and
>> eventually gcov/gprof reports.
>> I don't think full patchew reports are useful in a mailbox.

I disagree. They could certainly be made terser but I think the general
workflow of posting automated testing reports to patch series is a
useful one.

--
Alex Bennée

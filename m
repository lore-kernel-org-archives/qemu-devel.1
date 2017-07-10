Received: from eggs.gnu.org ([2001:4830:134:3::10]:52411)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dUXRL-0005J6-Q5
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 08:05:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dUXRI-0004xZ-Ma
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 08:05:23 -0400
Received: from mail-it0-f42.google.com ([209.85.214.42]:38134)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dUXRI-0004x9-Hr
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 08:05:20 -0400
Received: by mail-it0-f42.google.com with SMTP id k192so35925617ith.1
	for <qemu-devel@nongnu.org>; Mon, 10 Jul 2017 05:05:20 -0700 (PDT)
MIME-Version: 1.0
Sender: philippe.mathieu.daude@gmail.com
In-Reply-To: <CAAdtpL6tLfG1dUO8nmGvb2vAtX-OTkoFKWQt=MdxUULyonE8AA@mail.gmail.com>
References: <20170621144814.15324-1-alex.bennee@linaro.org>
	<CAFEAcA91jcDezunfEKwB+DBdzrEAFYWHKRyFmPyCNYSs_4N4JA@mail.gmail.com>
	<6152fff6-f4db-b0c2-bf20-181364544412@amsat.org>
	<87wp84rr6h.fsf@linaro.org>
	<CAAdtpL6tLfG1dUO8nmGvb2vAtX-OTkoFKWQt=MdxUULyonE8AA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 10 Jul 2017 09:04:19 -0300
Message-ID: <CAAdtpL7kaQSm_Kbn+DrD9Kkzj3JH47pM+-RxXYB=_fyEb+7NxQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 00/21] Docker and shippable updates
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

On Thu, Jun 22, 2017 at 12:42 PM, Philippe Mathieu-Daud=C3=A9
<f4bug@amsat.org> wrote:
> On Thu, Jun 22, 2017 at 12:13 PM, Alex Benn=C3=A9e <alex.bennee@linaro.or=
g> wrote:
>> Now we've been running shippable for a while is it worth turning on the
>> IRC notifications?
>
> What about moving such bot/scripts notifications in another channel
> like #QEMU-notifications?

ping?

> It is often hard to follow 3 concurrent topics while the travis-ci bot
> disrupts entering/broadcasting/leaving...
> I'd also like to see here checkpatch/patchew stripped output, and
> eventually gcov/gprof reports.
> I don't think full patchew reports are useful in a mailbox.

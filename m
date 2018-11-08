Received: from eggs.gnu.org ([2001:4830:134:3::10]:41503)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gKoce-0008C6-W5
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 13:01:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gKocP-0007DJ-F8
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 13:01:32 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:40547)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gKocL-00070W-Nn
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 13:01:23 -0500
Received: by mail-ot1-x343.google.com with SMTP id s5so5025113oth.7
	for <qemu-devel@nongnu.org>; Thu, 08 Nov 2018 10:01:16 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAP+75-WTmYUAWgOZ7cf2jsaqvQVv+atBzatUgDOhudz1kqPg4g@mail.gmail.com>
References: <20181108143422.15955-1-philmd@redhat.com>
	<20181108171716.GN12503@habkost.net>
	<CAFEAcA-t5qOHngv9ciTkuakmT84N7QV4c0=TYMD-NUgh5uT_DA@mail.gmail.com>
	<CAP+75-WTmYUAWgOZ7cf2jsaqvQVv+atBzatUgDOhudz1kqPg4g@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 8 Nov 2018 18:00:54 +0000
Message-ID: <CAFEAcA8XK51Uun6MUQDSOMAN7aCQ0TtKzQBWtVXtBx9=A5yECw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] scripts: Remove unused python imports
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Cleber Rosa <crosa@redhat.com>

On 8 November 2018 at 17:41, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com=
> wrote:
> On Thu, Nov 8, 2018 at 6:25 PM Peter Maydell <peter.maydell@linaro.org> w=
rote:
>> On 8 November 2018 at 17:17, Eduardo Habkost <ehabkost@redhat.com> wrote=
:
>> > On Thu, Nov 08, 2018 at 03:34:22PM +0100, Philippe Mathieu-Daud=C3=A9 =
wrote:
>> >> Reported-by: LGTM code review
>> >> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> >
>> > Queueing for 3.2, thanks.
>>
>> Next release after 3.1 will be 4.0, by the way -- we're moving
>> to "bump major version every year".
>
> So major versions help to remember the 12th anniversary of QEMU?
>
> Why not start at 19.0?

We had this discussion when we agreed on the new version policy;
I don't want to reopen it.

thanks
-- PMM

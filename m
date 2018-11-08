Received: from eggs.gnu.org ([2001:4830:134:3::10]:43887)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gKojd-000778-6L
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 13:08:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gKojZ-0005cT-76
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 13:08:53 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43320)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gKojY-0005Km-Vh
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 13:08:49 -0500
Received: by mail-wr1-f65.google.com with SMTP id y3-v6so21955398wrh.10
	for <qemu-devel@nongnu.org>; Thu, 08 Nov 2018 10:08:37 -0800 (PST)
References: <20181108143422.15955-1-philmd@redhat.com>
	<20181108171716.GN12503@habkost.net>
	<CAFEAcA-t5qOHngv9ciTkuakmT84N7QV4c0=TYMD-NUgh5uT_DA@mail.gmail.com>
	<CAP+75-WTmYUAWgOZ7cf2jsaqvQVv+atBzatUgDOhudz1kqPg4g@mail.gmail.com>
	<CAFEAcA8XK51Uun6MUQDSOMAN7aCQ0TtKzQBWtVXtBx9=A5yECw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <5f495bd7-8489-4e8f-8fd5-d0bb28787fa4@redhat.com>
Date: Thu, 8 Nov 2018 19:08:34 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8XK51Uun6MUQDSOMAN7aCQ0TtKzQBWtVXtBx9=A5yECw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] scripts: Remove unused python imports
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Eduardo Habkost <ehabkost@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Cleber Rosa <crosa@redhat.com>

On 8/11/18 19:00, Peter Maydell wrote:
> On 8 November 2018 at 17:41, Philippe Mathieu-Daudé <philmd@redhat.com> wrote:
>> On Thu, Nov 8, 2018 at 6:25 PM Peter Maydell <peter.maydell@linaro.org> wrote:
>>> On 8 November 2018 at 17:17, Eduardo Habkost <ehabkost@redhat.com> wrote:
>>>> On Thu, Nov 08, 2018 at 03:34:22PM +0100, Philippe Mathieu-Daudé wrote:
>>>>> Reported-by: LGTM code review
>>>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>>>>
>>>> Queueing for 3.2, thanks.
>>>
>>> Next release after 3.1 will be 4.0, by the way -- we're moving
>>> to "bump major version every year".
>>
>> So major versions help to remember the 12th anniversary of QEMU?
>>
>> Why not start at 19.0?
> 
> We had this discussion when we agreed on the new version policy;
> I don't want to reopen it.

Sorry I missed it, I'll look in the archives.

Anyway there are no information about merge window in the wiki.
When I started it was not easy to understand it and why patches sent 
when 'merge window is close' fall under the crap and are unnoticed, thus 
it is better to wait before to send, or resend them.
I'd appreciate if someone add this (Contribute/SubmitAPatch is probably 
the page to modify), also describing than some maintainers agree to take 
patches in their -next queue, even when merge window is closed
Also you could add the expected dates for the next releases there.

Regards,

Phil.

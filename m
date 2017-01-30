Received: from eggs.gnu.org ([2001:4830:134:3::10]:35526)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cYC1g-0007LR-IT
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 08:29:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cYC1d-0003QC-DS
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 08:29:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57314)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1cYC1d-0003Py-8A
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 08:29:41 -0500
References: <20170127193504.32290-1-pbonzini@redhat.com>
	<8d16a464-18c0-feb6-d1dd-1a9e3d8c84aa@redhat.com>
	<CAFEAcA9a-eybevVZ2ad3tTD7FfJvUp_eShSx65h8XUtKAUyUEA@mail.gmail.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <2aac246f-995e-d0bf-7d60-eb3b71a01b32@redhat.com>
Date: Mon, 30 Jan 2017 14:29:38 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9a-eybevVZ2ad3tTD7FfJvUp_eShSx65h8XUtKAUyUEA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL v2 00/41] Misc patches for 2017-01-27
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On 01/30/17 13:57, Peter Maydell wrote:
> On 30 January 2017 at 12:33, Laszlo Ersek <lersek@redhat.com> wrote:
>> Peter,
>>
>> On 01/27/17 20:35, Paolo Bonzini wrote:
>>> The following changes since commit 29ba0cdc1fd1300f910d150c03a0f74236083bf7:
>>>
>>>   Merge remote-tracking branch 'remotes/armbru/tags/pull-qapi-2017-01-27' into staging (2017-01-27 15:20:08 +0000)
>>>
>>> are available in the git repository at:
>>>
>>>   git://github.com/bonzini/qemu.git tags/for-upstream
>>>
>>> for you to fetch changes up to 6da67de6803e93cbb7e93ac3497865832f8c00ea:
>>>
>>>   memory: don't sign-extend 32-bit writes (2017-01-27 18:08:00 +0100)
>>>
>>
>> Can you please pull this v2?
> 
> I am currently processing it, yes. Paolo only sent it to the list

Apologies, I missed that.

> late on Friday evening, and I don't generally work weekends,

I didn't try to imply that you should have -- I also don't check my work
email over the weekend, on purpose. I check the occasional public list
archive, maybe.

> so it's not like this has been lying around for a long time...

Yeah I was conflicted whether I should ping you or not... The very first
version of the patches goes back to October 2015; I may have gotten
over-enthusiastic about the feature being finally merged, and possibly
made the wrong call. Sorry.

(BTW I know about <http://patchew.org/QEMU/>, and for the v1 pull req, I
did notice quickly enough the conflict ("Failed in applying to current
master"), even before reading your feedback on-list; but for v2, patchew
only says "Series not complete".)

It's difficult to ask politely in email... I tend to start with
apologizing and various disclaimers, saying "please" and "thank you"
profusely, but I've also been told that I should be more "assertive"...
Sigh.

Thank you anyway, and sorry about the poke. It was meant in good faith.
Laszlo

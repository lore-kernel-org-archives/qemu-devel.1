Received: from eggs.gnu.org ([2001:4830:134:3::10]:41439)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fTS33-0003Q2-Ed
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 09:12:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fTS32-0001Mj-Hr
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 09:12:21 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47966 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fTS32-0001MV-DL
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 09:12:20 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180614124330.12224-1-armbru@redhat.com>
	<CAFEAcA9CR3AV3WUronfitr-_AAjw5O32WMQ6_7x4EpE=YQwqXA@mail.gmail.com>
Date: Thu, 14 Jun 2018 15:12:19 +0200
In-Reply-To: <CAFEAcA9CR3AV3WUronfitr-_AAjw5O32WMQ6_7x4EpE=YQwqXA@mail.gmail.com>
	(Peter Maydell's message of "Thu, 14 Jun 2018 13:49:11 +0100")
Message-ID: <87vaalikb0.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PULL v2 0/3] Miscellaneous patches for 2018-06-13
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

Peter Maydell <peter.maydell@linaro.org> writes:

> On 14 June 2018 at 13:43, Markus Armbruster <armbru@redhat.com> wrote:
>> The following changes since commit 2ab09bf2f9f55b9fb8d2de6eb2ba2a8570e268e2:
>>
>>   Merge remote-tracking branch 'remotes/kraxel/tags/usb-20180612-pull-request' into staging (2018-06-12 15:34:34 +0100)
>>
>> are available in the Git repository at:
>>
>>   git://repo.or.cz/qemu/armbru.git tags/pull-misc-2018-06-13-v2
>>
>> for you to fetch changes up to 3190af2dea9aceee72a0dfa087b8ea67ecff5519:
>>
>>   Purge uses of banned g_assert_FOO() (2018-06-14 14:33:28 +0200)
>>
>> ----------------------------------------------------------------
>> Miscellaneous patches for 2018-06-13
>>
>
> Too late, I already applied the first version...

No biggie, I can clean up the odd spacing in a follow-up.

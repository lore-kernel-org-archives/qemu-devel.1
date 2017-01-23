Received: from eggs.gnu.org ([2001:4830:134:3::10]:37107)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cVfCJ-0004VU-QS
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 09:02:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cVfCD-00083q-T1
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 09:02:15 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60590)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cVfCD-00083X-NY
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 09:02:09 -0500
References: <20170120133139.31080-1-pbonzini@redhat.com>
	<CAFEAcA89j4GXDCpDm7q9cB9hVzFMJy-q00ZmzyHut3KfCD8UyA@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <40c8bbcc-43f3-eaae-060b-39238351eee8@redhat.com>
Date: Mon, 23 Jan 2017 15:02:06 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA89j4GXDCpDm7q9cB9hVzFMJy-q00ZmzyHut3KfCD8UyA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL v3 00/32] Misc patches for 2017-01-11
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



On 23/01/2017 11:07, Peter Maydell wrote:
> On 20 January 2017 at 13:31, Paolo Bonzini <pbonzini@redhat.com> wrote:
>> The following changes since commit 2ccede18bd24fce5db83fef3674563a1f256717b:
>>
>>   Merge remote-tracking branch 'remotes/vivier/tags/m68k-for-2.9-pull-request' into staging (2017-01-16 12:41:35 +0000)
>>
>> are available in the git repository at:
>>
>>   git://github.com/bonzini/qemu.git tags/for-upstream
>>
>> for you to fetch changes up to abc62c89f3191774dbd600a2caec803cbf557160:
>>
>>   pc.h: move x-mach-use-reliable-get-clock compat entry to PC_COMPAT_2_8 (2017-01-20 13:22:57 +0100)
> 
> Merge conflict here in the bit with the x-mach-use-reliable-get-clock
> entry in the PC_COMPAT stuff, so you should check that it got
> resolved correctly this time around.

Yes, the resolution matches what I sent as v4.

Paolo

> Applied to master, thanks.
> 
> thanks
> -- PMM
> 

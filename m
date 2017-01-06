Received: from eggs.gnu.org ([2001:4830:134:3::10]:37701)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cPWCI-0001yr-IM
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 10:12:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cPWCH-0000JY-H3
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 10:12:50 -0500
Received: from mail-ua0-x235.google.com ([2607:f8b0:400c:c08::235]:36045)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cPWCH-0000JQ-Ch
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 10:12:49 -0500
Received: by mail-ua0-x235.google.com with SMTP id 88so403029512uaq.3
	for <qemu-devel@nongnu.org>; Fri, 06 Jan 2017 07:12:49 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170104145133.GD8194@stefanha-x1.localdomain>
References: <a6803686-9435-0276-0118-10961dc97e04@redhat.com>
	<20170103155347.GF14707@stefanha-x1.localdomain>
	<68e906ee-5604-644c-78cd-d39f0d164406@redhat.com>
	<20170104145133.GD8194@stefanha-x1.localdomain>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Jan 2017 15:12:28 +0000
Message-ID: <CAFEAcA_+33bEyPab4pzAF8pR8W+XixyaUrM+1dyWH4hyDUWuqw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] Proposal for 2.9 release schedule
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel <qemu-devel@nongnu.org>

On 4 January 2017 at 14:51, Stefan Hajnoczi <stefanha@redhat.com> wrote:
> On Tue, Jan 03, 2017 at 05:06:13PM +0100, Paolo Bonzini wrote:
>> On 03/01/2017 16:53, Stefan Hajnoczi wrote:
>> > On Fri, Dec 23, 2016 at 03:15:58PM +0100, Paolo Bonzini wrote:
>> >> Considering that Easter is on April 16th, we'd probably want to have the
>> >> release before that date even in case of a slip.
>> >>
>> >> On the other hand, the Christmas / New Year break here means that we'll
>> >> have to make the development time 1-2 week shorter in practice.
>> >>
>> >> 2016-02-21     2.9 soft freeze
>> >> 2016-03-07     hard freeze / rc0
>> >> 2016-03-28     rc3 (+3 weeks)
>> >> 2016-04-04     rc4 or release
>> >> 2016-04-11     release (if rc4)
>> >>
>> >> One possibility is to make soft freeze happen a few days later.
>> >> Peter/Stefan, how did the experiment go with the new rules for soft
>> >> freeze?  Is it worth repeating it for 2.9 and would it make sense to
>> >> shorten soft freeze given the new rules?
>> >
>> > I would shorten the soft freeze by 1 week.
>> >
>> > Overall the 2.8 release went smoothly.  We got unlucky right at the end
>> > with a release blocker but otherwise it was fine.
>>
>> Then what about soft freeze on 2016-02-28?
>
> Sounds good to me.  Peter?

Are we retaining the "make sure you have your pull requests on the list
by the softfreeze date" rule this time around?

thanks
-- PMM

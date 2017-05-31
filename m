Received: from eggs.gnu.org ([2001:4830:134:3::10]:47844)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dG5OJ-00050L-O7
	for qemu-devel@nongnu.org; Wed, 31 May 2017 11:18:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dG5OG-00004z-KT
	for qemu-devel@nongnu.org; Wed, 31 May 2017 11:18:31 -0400
Received: from mail-wm0-x22a.google.com ([2a00:1450:400c:c09::22a]:34452)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dG5OG-0008W6-CB
	for qemu-devel@nongnu.org; Wed, 31 May 2017 11:18:28 -0400
Received: by mail-wm0-x22a.google.com with SMTP id 123so34721806wmg.1
	for <qemu-devel@nongnu.org>; Wed, 31 May 2017 08:18:28 -0700 (PDT)
References: <CAJSP0QVzoN=2rv_HUNf0oR_FQg=5xJ9UQbLqq0rj8OuYb8ZByw@mail.gmail.com>
	<CAFEAcA-AjqsFnk8O3vVO-zhWwowfgZuJi0PWgezPO6K-Ye2cqw@mail.gmail.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <CAFEAcA-AjqsFnk8O3vVO-zhWwowfgZuJi0PWgezPO6K-Ye2cqw@mail.gmail.com>
Date: Wed, 31 May 2017 16:18:41 +0100
Message-ID: <87zidtrr5a.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC] QEMU 2.10 release schedule
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-devel <qemu-devel@nongnu.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> On 30 May 2017 at 11:11, Stefan Hajnoczi <stefanha@gmail.com> wrote:
>> Here is a first stab at the next release schedule:
>>
>> Beginning of development phase: 2017-04-20
>> Soft feature freeze: 2017-07-18
>> -rc0: 2017-07-25
>> -rc1: 2017-08-01
>> -rc2: 2017-08-08
>> -rc3: 2017-08-15
>> -rc4: 2017-08-22
>
> Are we going with the same definitions of soft/hard freeze
> as last time around?
>
> (I thought last release was a complete mess in terms of
> getting code in in an orderly manner for the freeze,
> personally...)

Do we want to have a broad plan for the order things need to go in
before the feature freeze or stick to a first to the gate approach?

Obviously we don't want to stall the process waiting for delayed series
that might end up getting dropped but having the broad sketches might
make it easier for developers to prioritise what patches queues to drain
first?

--
Alex Bennée

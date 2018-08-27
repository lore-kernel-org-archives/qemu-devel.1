Received: from eggs.gnu.org ([208.118.235.92]:58320)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fuFs7-0004B4-GK
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 07:39:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fuFmW-0008Kw-CN
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 07:34:05 -0400
Received: from mail-oi0-x22a.google.com ([2607:f8b0:4003:c06::22a]:37870)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fuFmW-0008KB-4q
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 07:34:04 -0400
Received: by mail-oi0-x22a.google.com with SMTP id p84-v6so26638850oic.4
	for <qemu-devel@nongnu.org>; Mon, 27 Aug 2018 04:34:03 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180827124058.36aa13ee.cohuck@redhat.com>
References: <20180824133757.1cbdba75.cohuck@redhat.com>
	<a29f4cdd-8012-d46e-8984-b4e223f1957f@redhat.com>
	<20180827124058.36aa13ee.cohuck@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 27 Aug 2018 12:33:43 +0100
Message-ID: <CAFEAcA_k1jD8TFOihFn-CJ8fDSpKPv2g5LCXMhJQzuxkz+1ZeQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [RFD] [s390x] Tweaking the s390x maintainership
 setup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x <qemu-s390x@nongnu.org>, Richard Henderson <rth@twiddle.net>

On 27 August 2018 at 11:40, Cornelia Huck <cohuck@redhat.com> wrote:
> On Mon, 27 Aug 2018 11:26:21 +0200
> David Hildenbrand <david@redhat.com> wrote:
>
>> On 24.08.2018 13:37, Cornelia Huck wrote:
>> > * I'd also like to have a designated backup for the overall
>> >   maintainership, especially for when I'm on vacation (like the first
>> >   two weeks of September, just to let you know :) or otherwise
>> >   unavailable, but also for sanity. Likely needs to be a non-IBMer due
>> >   to the tcg problem.
>>
>> Either Thomas or I could do that. I will be on vacation the first two
>> weeks of September, too ;) Thomas, interested?
>
> Maybe both of you? I doubt we'll be on vacation during the same time
> period every time ;)

Given that I'm also going to be on holiday, there will
not be anybody applying pullrequests, so it's a bit moot :-)

thanks
-- PMM

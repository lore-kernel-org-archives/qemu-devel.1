Received: from eggs.gnu.org ([2001:4830:134:3::10]:59262)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fDUiL-0006DK-7n
	for qemu-devel@nongnu.org; Tue, 01 May 2018 08:49:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fDUiG-0003mQ-NN
	for qemu-devel@nongnu.org; Tue, 01 May 2018 08:49:01 -0400
Received: from mail-ot0-x230.google.com ([2607:f8b0:4003:c0f::230]:40250)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fDUiG-0003lR-HX
	for qemu-devel@nongnu.org; Tue, 01 May 2018 08:48:56 -0400
Received: by mail-ot0-x230.google.com with SMTP id n1-v6so12815784otf.7
	for <qemu-devel@nongnu.org>; Tue, 01 May 2018 05:48:56 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180501122436.GA14803@stefanha-x1.localdomain>
References: <CAFEAcA-hha7jMSfPTdNEVKhuJr4nwAx4wKmEk5E9+j-JS4U14w@mail.gmail.com>
	<20180501122436.GA14803@stefanha-x1.localdomain>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 1 May 2018 13:48:35 +0100
Message-ID: <CAFEAcA8PKvW2P717b=TAfHHz-GYTYFcW0Z-MLMkSHfsMDhZVbA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] release retrospective, next release timing,
 numbering
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 1 May 2018 at 13:24, Stefan Hajnoczi <stefanha@redhat.com> wrote:
> On Fri, Apr 27, 2018 at 04:51:03PM +0100, Peter Maydell wrote:
>> (2) release timing:
>>  * usual schedule would give us a next release mid-to-late August
>>  * unless I can persuade Stefan to do the release management this
>>    cycle we might need to wind that in by a couple of weeks so
>>    it's definitely done by the middle of August, to avoid a clash
>>    with a personal commitment
>
> I will be offline mid-August to mid-September, sorry.  Someone else can
> volunteer to do the release.

I think the best approach is that we'll make sure the dates for
the release are set so it's definitely done by mid-August,
and we'll find a suitable volunteer to do the post-release
pull request handling for late August/September...

-- PMM

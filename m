Received: from eggs.gnu.org ([2001:4830:134:3::10]:41701)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dkCti-0008Be-HN
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 13:23:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dkCth-0008So-Hg
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 13:23:26 -0400
Received: from mail-wm0-x236.google.com ([2a00:1450:400c:c09::236]:37405)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dkCth-0008Sg-9t
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 13:23:25 -0400
Received: by mail-wm0-x236.google.com with SMTP id b189so2799220wmd.0
	for <qemu-devel@nongnu.org>; Tue, 22 Aug 2017 10:23:25 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <7506ab15-7fc8-d46d-12fd-40e4d8820575@freebsd.org>
References: <9a2562ad-5e8b-52bc-1a59-9e7b7e854ebf@freebsd.org>
	<CAFEAcA9FOVoTZNr66Y7-Jdq8k6hfnXM4-vAaxaghKTiRcq+mRg@mail.gmail.com>
	<7506ab15-7fc8-d46d-12fd-40e4d8820575@freebsd.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 22 Aug 2017 18:23:01 +0100
Message-ID: <CAFEAcA_B7d4SLnZA7zZsnZBAKeMFQEVJU-1okX8EL1vTt3b4oQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] QEMU -> Github Exporter down?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sean Bruno <sbruno@freebsd.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 22 August 2017 at 18:04, Sean Bruno <sbruno@freebsd.org> wrote:
>
>
> On 08/22/17 10:57, Peter Maydell wrote:
>> On 22 August 2017 at 17:52, Sean Bruno <sbruno@freebsd.org> wrote:
>>> I note that there hasn't been any updates to the github copy of the main
>>> project repo.  Just curious if I missed a thing or if someone can go
>>> look to see what's up.
>>
>> Hmm? https://github.com/qemu/qemu has 1f29673 as its head,
>> which is indeed the most recent commit to master.

> Huh ... Ok.  I guess I should have checked the head revision.  Sorry for
> the noise.

No problem. Master's very quiet at the moment because we're close to
releasing 2.10.

thanks
-- PMM

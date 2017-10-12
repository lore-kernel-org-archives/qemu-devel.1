Received: from eggs.gnu.org ([2001:4830:134:3::10]:44525)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e2aTO-0008Hk-4k
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 06:12:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e2aTN-0007O8-7q
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 06:12:14 -0400
Received: from mail-wm0-x235.google.com ([2a00:1450:400c:c09::235]:57278)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e2aTN-0007KV-1v
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 06:12:13 -0400
Received: by mail-wm0-x235.google.com with SMTP id l68so11848243wmd.5
	for <qemu-devel@nongnu.org>; Thu, 12 Oct 2017 03:12:13 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20171012100736.GH16125@redhat.com>
References: <20171011083604.11820-1-kraxel@redhat.com>
	<CAFEAcA9uXw7XYOBu9cKY+B=OWNbS=cRp7BKcXacLTaRLx9RWdA@mail.gmail.com>
	<20171011154951.GA6163@redhat.com>
	<CAFEAcA8OZALycKmsrC=MrftfF0YytXzRxGrzbetmSvddfTVf1g@mail.gmail.com>
	<20171012082456.GB16125@redhat.com>
	<1507800626.26812.13.camel@redhat.com>
	<20171012093337.GE16125@redhat.com>
	<1507802687.26812.17.camel@redhat.com>
	<20171012100736.GH16125@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Oct 2017 11:11:51 +0100
Message-ID: <CAFEAcA9=eREYRnsAC=_gGpmY2a2ERaA8Xg3y1_F3vcBai0P-jA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/10] Ui 20171011 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On 12 October 2017 at 11:07, Daniel P. Berrange <berrange@redhat.com> wrote:
> On Thu, Oct 12, 2017 at 12:04:47PM +0200, Gerd Hoffmann wrote:
>>   Hi,
>>
>> > Not AFAICT - if i try it just never completes connect()
>>
>> Hmm, so maybe we should mirror the thing on git.qemu.org and use that?
>
> Can that be made 100% automated - I don't want to have to push changes to
> two different git repos.

All our git.qemu.org mirrors are automated, I think (there's a cron
job on the server somewhere that syncs them with the upstream, IIRC?)

thanks
-- PMM

Received: from eggs.gnu.org ([2001:4830:134:3::10]:39698)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cj3y7-0000fT-Cp
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 08:07:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cj3y1-00061J-QG
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 08:06:59 -0500
Received: from mail-wr0-x230.google.com ([2a00:1450:400c:c0c::230]:36375)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cj3y1-000619-KS
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 08:06:53 -0500
Received: by mail-wr0-x230.google.com with SMTP id u108so29764484wrb.3
	for <qemu-devel@nongnu.org>; Wed, 01 Mar 2017 05:06:53 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170228124056.5074-1-dgilbert@redhat.com>
References: <20170228124056.5074-1-dgilbert@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 1 Mar 2017 13:06:31 +0000
Message-ID: <CAFEAcA9M4-ghtYHTaSYPDuDjEECbJ_NTQMR_d4X03hgqBBr-3A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL 00/27] migration queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Laurent Vivier <lvivier@redhat.com>, pasic@linux.vnet.ibm.com, vsementsov@virtuozzo.com, Juan Quintela <quintela@redhat.com>, Ashijeet Acharya <ashijeetacharya@gmail.com>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, danielhb@linux.vnet.ibm.com

On 28 February 2017 at 12:40, Dr. David Alan Gilbert (git)
<dgilbert@redhat.com> wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> The following changes since commit 6181478f6395cdd9d6ffd99623d0c9f39ea53606:
>
>   Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-request' into staging (2017-02-28 08:46:03 +0000)
>
> are available in the git repository at:
>
>   git://github.com/dagrh/qemu.git tags/pull-migration-20170228a
>
> for you to fetch changes up to 665414ad06aa1bc92e615db9641e58fb13d07de1:
>
>   postcopy: Add extra check for COPY function (2017-02-28 11:30:24 +0000)
>
> ----------------------------------------------------------------
> Migration pull
>
> Note: The 'postcopy: Update userfaultfd.h header' is part of
> Paolo's header update and will disappear if applied after it.

Is that a linux-headers update not done via the update script? :-(

thanks
-- PMM

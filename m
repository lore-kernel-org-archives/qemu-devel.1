Received: from eggs.gnu.org ([208.118.235.92]:58747)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fuJhd-0000Uh-SH
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 11:45:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fuJgd-0002c7-QC
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 11:44:17 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:37772)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fuJgd-0002bf-AO
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 11:44:15 -0400
Received: by mail-oi0-x243.google.com with SMTP id p84-v6so28093081oic.4
	for <qemu-devel@nongnu.org>; Mon, 27 Aug 2018 08:44:15 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180827100431.7915-1-quintela@redhat.com>
References: <20180827100431.7915-1-quintela@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 27 Aug 2018 16:43:54 +0100
Message-ID: <CAFEAcA_DHVuER-v_3=kOi5yCMTsvAj6qe7qJxLbZfvmLGo6tLg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/9] Disable tests when device is not
 compiled in
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Laurent Vivier <lvivier@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Peter Xu <peterx@redhat.com>

On 27 August 2018 at 11:04, Juan Quintela <quintela@redhat.com> wrote:
> The following changes since commit 235c82acca0491465e94be3cae2583b42d37c859:
>
>   Merge remote-tracking branch 'remotes/otubo/tags/pull-seccomp-20180823' into staging (2018-08-25 13:08:57 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/juanquintela/qemu.git tags/check/20180827
>
> for you to fetch changes up to ee1f6c812b3240420dff07a3860060b7d4abfe09:
>
>   check: Move wdt_ib700 test to common (2018-08-27 11:27:07 +0200)
>
> ----------------------------------------------------------------
> check/next for 20180827
>
> Hi
>
> This are the patches that are reviewed to disable tests when devices
> are not compiled in.  I will stop now until the changes to qtest are
> finished.
>
> Later, Juan.
>
Applied, thanks.

-- PMM

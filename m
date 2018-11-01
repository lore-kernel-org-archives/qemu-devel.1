Received: from eggs.gnu.org ([2001:4830:134:3::10]:60577)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gIDQp-0005uK-HU
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 09:54:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gIDQo-0006u4-Q8
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 09:54:43 -0400
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c]:38994)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gIDQo-0006hU-LL
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 09:54:42 -0400
Received: by mail-ot1-x32c.google.com with SMTP id g27so4916493oth.6
	for <qemu-devel@nongnu.org>; Thu, 01 Nov 2018 06:54:25 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20181031003120.26771-1-ehabkost@redhat.com>
References: <20181031003120.26771-1-ehabkost@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 1 Nov 2018 13:54:04 +0000
Message-ID: <CAFEAcA_Jnb3iXMqbgdhM0LEj=-V5Hg=uywLbDufKtnOQEzzAEw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/15] Python queue, 2018-10-30
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, Cleber Rosa <crosa@redhat.com>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>

On 31 October 2018 at 00:31, Eduardo Habkost <ehabkost@redhat.com> wrote:
> Sorry for submitting this at the last minute.
>
> The following changes since commit a2e002ff7913ce93aa0f7dbedd2123dce5f1a9cd:
>
>   Merge remote-tracking branch 'remotes/vivier2/tags/qemu-trivial-for-3.1-pull-request' into staging (2018-10-30 15:49:55 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/ehabkost/qemu.git tags/python-next-pull-request
>
> for you to fetch changes up to e301e65c97142c4d2a2adf35f5a4fa73d65d8a4f:
>
>   scripts/qemu.py: use a more consistent docstring style (2018-10-30 21:13:54 -0300)
>
> ----------------------------------------------------------------
> Python queue, 2018-10-30
>
> * Makefile rule for running acceptance tests
>   (make check-acceptance) (Cleber Rosa)
> * Make iotests compatible with Python 3
>   (Max Reitz)
> * device-crash-test whitelist update (Thomas Huth)
> * Misc cleanups (Cleber Rosa)
>
> ----------------------------------------------------------------

Applied, thanks.

-- PMM

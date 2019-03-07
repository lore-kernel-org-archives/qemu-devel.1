Received: from eggs.gnu.org ([209.51.188.92]:57292)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h1wLy-00014v-0o
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 11:58:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h1wLx-00017R-8a
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 11:58:41 -0500
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335]:34933)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1h1wLx-00016x-2D
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 11:58:41 -0500
Received: by mail-ot1-x335.google.com with SMTP id z19so14744946otm.2
	for <qemu-devel@nongnu.org>; Thu, 07 Mar 2019 08:58:40 -0800 (PST)
MIME-Version: 1.0
References: <20190222194146.13102-1-crosa@redhat.com>
In-Reply-To: <20190222194146.13102-1-crosa@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 7 Mar 2019 16:58:28 +0000
Message-ID: <CAFEAcA8_-SjYyZ8+O9vU5CcokvHS4rqxOa4GwdJbEgcxsP3HUA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/7] Python queue, 2019-02-22
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>, Fam Zheng <fam@euphon.net>, Qemu-block <qemu-block@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Markus Armbruster <armbru@redhat.com>

On Fri, 22 Feb 2019 at 19:41, Cleber Rosa <crosa@redhat.com> wrote:
>
> The following changes since commit 8eb29f1bf5a974dc4c11d2d1f5e7c7f7a62be116:
>
>   Merge remote-tracking branch 'remotes/awilliam/tags/vfio-updates-20190221.0' into staging (2019-02-22 15:48:04 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/clebergnu/qemu.git tags/python-next-pull-request
>
> for you to fetch changes up to 8f1c89ec7443e4fa2cf106d8fa1c1c97b6ddeffb:
>
>   Acceptance tests: expect boot to extract 2GiB+ initrd with linux-v4.16 (2019-02-22 14:07:01 -0500)
>
> ----------------------------------------------------------------
> Python queue, 2019-02-22
>
> Python:
> * introduce "python" directory with module namespace
> * log QEMU launch command line on qemu.QEMUMachine
>
> Acceptance Tests:
> * initrd 4GiB+ test
> * migration test
> * multi vm support in test class
> * bump Avocado version and drop ":avocado: enable"

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM

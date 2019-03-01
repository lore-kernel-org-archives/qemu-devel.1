Received: from eggs.gnu.org ([209.51.188.92]:41252)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gzjJb-00046M-QE
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 09:39:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gzjJY-00089X-DJ
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 09:39:05 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:39465)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gzjJU-00084d-W2
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 09:39:02 -0500
Received: by mail-oi1-x244.google.com with SMTP id b4so19644057oif.6
	for <qemu-devel@nongnu.org>; Fri, 01 Mar 2019 06:38:57 -0800 (PST)
MIME-Version: 1.0
References: <20190222194146.13102-1-crosa@redhat.com>
In-Reply-To: <20190222194146.13102-1-crosa@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 1 Mar 2019 14:38:45 +0000
Message-ID: <CAFEAcA-PErYY12Dn9Rnjb8avmtnTXUg-Taqa=HDkdYYBfDW07A@mail.gmail.com>
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


Hi -- this pull request appears to be signed with a GPG key that
I've never seen before and which is signed only by itself.
Could you arrange to get some more signatures on it, please ?

thanks
-- PMM

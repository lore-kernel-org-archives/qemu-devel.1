Received: from eggs.gnu.org ([209.51.188.92]:37966)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h2HFA-0006yM-4e
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 10:17:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h2HF9-0002y0-9v
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 10:17:04 -0500
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b]:39081)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1h2HF9-0002m7-1Z
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 10:17:03 -0500
Received: by mail-ot1-x32b.google.com with SMTP id e15so17633251otk.6
	for <qemu-devel@nongnu.org>; Fri, 08 Mar 2019 07:17:01 -0800 (PST)
MIME-Version: 1.0
References: <1551979804-6060-1-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1551979804-6060-1-git-send-email-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 8 Mar 2019 15:16:48 +0000
Message-ID: <CAFEAcA974DRP7+RafFFF9FGjh-cOXRx7DRbaAHckWeHY1owzAg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/57] qgraph merge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Thomas Huth <thuth@redhat.com>, lviver@redhat.com

On Thu, 7 Mar 2019 at 17:44, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> The following changes since commit 3a75ef6a0fe397b0d36930415be6b123750a6afe:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/usb-20190307-pull-request' into staging (2019-03-07 14:06:42 +0000)
>
> are available in the git repository at:
>
>
>   git://github.com/bonzini/qemu.git tags/for-upstream-qgraph
>
> for you to fetch changes up to 15bd8b2cdabbf8f3371f2e30b1ef04cf9fe9ec87:
>
>   qos-test: megasas test node (2019-03-07 17:25:09 +0100)
>
> ----------------------------------------------------------------
> qgraph project from GSoC 2018
>
> ----------------------------------------------------------------

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM

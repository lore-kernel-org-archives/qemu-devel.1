Received: from eggs.gnu.org ([209.51.188.92]:59004)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gzLHf-0001dR-2S
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 07:59:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gzLHe-0007K3-5Q
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 07:59:30 -0500
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230]:38294)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gzLHd-0007Jv-VF
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 07:59:30 -0500
Received: by mail-oi1-x230.google.com with SMTP id q81so16382784oic.5
	for <qemu-devel@nongnu.org>; Thu, 28 Feb 2019 04:59:29 -0800 (PST)
MIME-Version: 1.0
References: <20190226165013.24867-1-eblake@redhat.com>
In-Reply-To: <20190226165013.24867-1-eblake@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 Feb 2019 12:59:17 +0000
Message-ID: <CAFEAcA9aqX+YanZHKbZfGVwNdEZ27SaoZ44M1in-jgO5wFMVyA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v2 0/3] NBD patches for 2019-02-25
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Tue, 26 Feb 2019 at 16:56, Eric Blake <eblake@redhat.com> wrote:
>
> The following changes since commit d88d85f1f0625d57e9f354aa0874c4c8b5d1fb47:
>
>   Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-request' into staging (2019-02-25 17:28:04 +0000)
>
> are available in the Git repository at:
>
>   https://repo.or.cz/qemu/ericb.git tags/pull-nbd-2019-02-25-v2
>
> for you to fetch changes up to 3e6f45446b11ccc20b4b751f70331f03d70369b8:
>
>   iotests: avoid broken pipe with certtool (2019-02-26 10:45:37 -0600)
>
> (v2: pull in Andrey's v3 python patch per last-minute list emails)
>
> ----------------------------------------------------------------
> nbd patches for 2019-02-25
>
> - iotest failure fixes for tests related to NBD
>
> ----------------------------------------------------------------

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM

Received: from eggs.gnu.org ([209.51.188.92]:55024)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gmgYd-0003sK-OK
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 10:04:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gmgYc-0000qp-PC
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 10:04:43 -0500
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332]:34439)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gmgYc-0000pX-J0
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 10:04:42 -0500
Received: by mail-ot1-x332.google.com with SMTP id t5so5512489otk.1
	for <qemu-devel@nongnu.org>; Thu, 24 Jan 2019 07:04:42 -0800 (PST)
MIME-Version: 1.0
References: <20190123155830.8459-1-dgilbert@redhat.com>
In-Reply-To: <20190123155830.8459-1-dgilbert@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 24 Jan 2019 15:04:29 +0000
Message-ID: <CAFEAcA97d7aumXD7xXN5G4agNb+zaBP2xpZ5OzCzksjHYiA0XA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/9] migration queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Juan Quintela <quintela@redhat.com>, lifei1214@126.com, xiaoguangrong@tencent.com, Peter Xu <peterx@redhat.com>, shirley17fei@gmail.com, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>

On Wed, 23 Jan 2019 at 16:05, Dr. David Alan Gilbert (git)
<dgilbert@redhat.com> wrote:
>
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> The following changes since commit 9f33051abce238ab43a23125e237aac8b0931b88:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/ipxe-20190122-pull-request' into staging (2019-01-22 19:24:10 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/dagrh/qemu.git tags/pull-migration-20190123a
>
> for you to fetch changes up to aecbfe9c64a6005f57b2132eb29db2ba7c0993fe:
>
>   migration: introduce pages-per-second (2019-01-23 15:51:47 +0000)
>
> ----------------------------------------------------------------
> Migration pull 2019-01-23
>
> New pages-per-second stat, a new test, and a bunch
> of fixes and tidy ups.
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM

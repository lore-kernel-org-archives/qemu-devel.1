Received: from eggs.gnu.org ([2001:4830:134:3::10]:33880)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cViWY-0006Te-Ra
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 12:35:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cViWY-0000WK-2c
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 12:35:22 -0500
Received: from mail-ua0-x235.google.com ([2607:f8b0:400c:c08::235]:34204)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cViWX-0000Vu-UC
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 12:35:22 -0500
Received: by mail-ua0-x235.google.com with SMTP id 35so115256093uak.1
	for <qemu-devel@nongnu.org>; Mon, 23 Jan 2017 09:35:21 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170123155737.3793-1-berrange@redhat.com>
References: <20170123155737.3793-1-berrange@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 23 Jan 2017 17:35:00 +0000
Message-ID: <CAFEAcA9z8R=w5HSmbfiwsRpHBw5U0k=pGwxmWPgr=Dfy8tUpfQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL v2 0/8] Merge io/ 2017-01-23
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 23 January 2017 at 15:57, Daniel P. Berrange <berrange@redhat.com> wrote:
> The following changes since commit 598cf1c805271564686f2d732b36f50c3c40dcdd:
>
>   Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into staging (2017-01-20 16:42:07 +0000)
>
> are available in the git repository at:
>
>   git://github.com/berrange/qemu tags/pull-qio-2017-01-23-2
>
> for you to fetch changes up to c1b412f1d94ba717896f876dbf59fffa91e596fc:
>
>   io: introduce a DNS resolver API (2017-01-23 15:32:46 +0000)
>
> ----------------------------------------------------------------
> Merge io/ 2017-01-23
>
> ----------------------------------------------------------------
>
> Daniel P. Berrange (8):
>   sockets: add ability to disable DNS resolution for InetSocketAddress
>   io: stop incrementing reference in qio_task_get_source
>   io: fix typo in docs for QIOTask
>   io: add ability to associate an opaque "result" with with a task
>   io: add ability to associate an error with a task
>   io: change the QIOTask callback signature
>   io: remove Error parameter from QIOTask thread worker
>   io: introduce a DNS resolver API

Applied, thanks.

-- PMM

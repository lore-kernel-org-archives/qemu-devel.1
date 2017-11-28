Received: from eggs.gnu.org ([2001:4830:134:3::10]:41635)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eJgpk-0006XG-Ik
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 09:26:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eJgpj-0008MI-Qa
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 09:26:00 -0500
Received: from mail-oi0-x22b.google.com ([2607:f8b0:4003:c06::22b]:46983)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eJgpj-0008M8-KQ
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 09:25:59 -0500
Received: by mail-oi0-x22b.google.com with SMTP id a81so342016oii.13
	for <qemu-devel@nongnu.org>; Tue, 28 Nov 2017 06:25:59 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171128112301.5636-1-berrange@redhat.com>
References: <20171128112301.5636-1-berrange@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 Nov 2017 14:25:38 +0000
Message-ID: <CAFEAcA-2iAVvxFHpV6urdU+PK=mhGsgjAxvny-+bP3W9ffEd+A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL (for 2.11) v1 0/1] Merge io 2017/11/28
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

On 28 November 2017 at 11:23, Daniel P. Berrange <berrange@redhat.com> wrote:
> The following changes since commit 5e19aed59ab48ca3c7f1e2da203eed27b91bef2d:
>
>   Merge remote-tracking branch 'remotes/dgibson/tags/ppc-for-2.11-20171127' into staging (2017-11-27 11:16:20 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/berrange/qemu tags/pull-qio-2017-11-28-1
>
> for you to fetch changes up to 2d7ad7c05e762d5b10a57eba9af1bb6b41700854:
>
>   sockets: avoid crash when cleaning up sockets for an invalid FD (2017-11-28 10:48:04 +0000)
>
> ----------------------------------------------------------------
> Merge qio 2017/11/28 v1
>
> ----------------------------------------------------------------
>
> Daniel P. Berrange (1):
>   sockets: avoid crash when cleaning up sockets for an invalid FD
>
>  util/qemu-sockets.c | 3 +++
>  1 file changed, 3 insertions(+)

Applied, thanks.

-- PMM

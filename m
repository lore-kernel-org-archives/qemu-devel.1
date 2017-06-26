Received: from eggs.gnu.org ([2001:4830:134:3::10]:54476)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dPX6m-0000hk-7v
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 12:43:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dPX6l-0001mo-C8
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 12:43:28 -0400
Received: from mail-wm0-x22c.google.com ([2a00:1450:400c:c09::22c]:35009)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dPX6l-0001mQ-4d
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 12:43:27 -0400
Received: by mail-wm0-x22c.google.com with SMTP id w126so2755462wme.0
	for <qemu-devel@nongnu.org>; Mon, 26 Jun 2017 09:43:26 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1498482584-15826-1-git-send-email-kwolf@redhat.com>
References: <1498482584-15826-1-git-send-email-kwolf@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 26 Jun 2017 17:43:05 +0100
Message-ID: <CAFEAcA-JFoybNcctE2HVZRNZainr7QYqN+DRghQ_NM8yc0Drmw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v2 00/60] Block layer patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Qemu-block <qemu-block@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 26 June 2017 at 14:09, Kevin Wolf <kwolf@redhat.com> wrote:
> The following changes since commit 931892e8a691a8a4151cc5fe1e13c14294bb28fb:
>
>   Merge remote-tracking branch 'remotes/rth/tags/pull-s390-20170623' into staging (2017-06-23 18:11:48 +0100)
>
> are available in the git repository at:
>
>
>   git://repo.or.cz/qemu/kevin.git tags/for-upstream
>
> for you to fetch changes up to 704e41ba789ad88158f051eee648d7087beffac7:
>
>   Merge remote-tracking branch 'mreitz/tags/pull-block-2017-06-26' into queue-block (2017-06-26 14:57:27 +0200)
>
> v2:
> - Dropped "virtio-pci: use ioeventfd even when KVM is disabled"
>
> ----------------------------------------------------------------
>
> Block layer patches
>

Applied, thanks.

-- PMM

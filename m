Received: from eggs.gnu.org ([2001:4830:134:3::10]:52141)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gRfNl-0003MK-87
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 10:34:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gRfNk-0007wH-BO
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 10:34:37 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:44385)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gRfNk-0007qj-3G
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 10:34:36 -0500
Received: by mail-ot1-x341.google.com with SMTP id f18so18878767otl.11
	for <qemu-devel@nongnu.org>; Tue, 27 Nov 2018 07:34:36 -0800 (PST)
MIME-Version: 1.0
References: <20181127140640.24830-1-kwolf@redhat.com>
In-Reply-To: <20181127140640.24830-1-kwolf@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 27 Nov 2018 15:34:23 +0000
Message-ID: <CAFEAcA8CeJxWZRhW2OZML4Ti48+648i-vh2WjFxQOsCXJoLF7Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/3] Block layer patches
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

On Tue, 27 Nov 2018 at 14:07, Kevin Wolf <kwolf@redhat.com> wrote:
>
> The following changes since commit d5d31c9a8ab5e87db4230602a6fd5da8eb13135c:
>
>   Merge remote-tracking branch 'remotes/ehabkost/tags/x86-for-3.1-pull-request' into staging (2018-11-27 09:55:05 +0000)
>
> are available in the Git repository at:
>
>   git://repo.or.cz/qemu/kevin.git tags/for-upstream
>
> for you to fetch changes up to 6da021815e752b3ca3a547eed53f3e92a8a35452:
>
>   nvme: Fix spurious interrupts (2018-11-27 12:59:00 +0100)
>
> ----------------------------------------------------------------
> Block layer patches:
>
> - block: Fix crash on migration with explicit child nodes
> - nvme: Fix spurious interrupts
>
> ----------------------------------------------------------------

Applied, thanks.

-- PMM

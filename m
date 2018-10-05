Received: from eggs.gnu.org ([2001:4830:134:3::10]:56163)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g8QXH-000223-IT
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 09:52:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g8QXF-00067Q-W1
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 09:52:55 -0400
Received: from mail-oi1-x229.google.com ([2607:f8b0:4864:20::229]:46234)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1g8QXF-00066s-Ep
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 09:52:53 -0400
Received: by mail-oi1-x229.google.com with SMTP id k64-v6so10422646oia.13
	for <qemu-devel@nongnu.org>; Fri, 05 Oct 2018 06:52:53 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20181004021943.22724-1-ehabkost@redhat.com>
References: <20181004021943.22724-1-ehabkost@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 5 Oct 2018 14:52:32 +0100
Message-ID: <CAFEAcA_uXAGWfMtcpVKyiaWF9DgjwrV2DqKtALicUZ4aeP3wXw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/4] Python queue, 2018-10-03
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Cleber Rosa <crosa@redhat.com>

On 4 October 2018 at 03:19, Eduardo Habkost <ehabkost@redhat.com> wrote:
> The following changes since commit dafd95053611aa14dda40266857608d12ddce658:
>
>   Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into staging (2018-10-02 18:27:18 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/ehabkost/qemu.git tags/python-next-pull-request
>
> for you to fetch changes up to cd0c3da730bc8369f0b6c1c6bf81babd9851060d:
>
>   scripts/device-crash-test: Remove entries for serial devices (2018-10-03 23:08:51 -0300)
>
> ----------------------------------------------------------------
> Python queue, 2018-10-03
>
> * Remove fixed serial device errors from device-crash-test
> * Remove unnecessary Python 2.6 compatibility code
>
> ----------------------------------------------------------------

Applied, thanks.

-- PMM

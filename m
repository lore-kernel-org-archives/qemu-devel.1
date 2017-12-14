Received: from eggs.gnu.org ([2001:4830:134:3::10]:38602)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ePWYT-00034j-Kr
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 11:40:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ePWYS-0006Q0-Qm
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 11:40:17 -0500
Received: from mail-oi0-x235.google.com ([2607:f8b0:4003:c06::235]:45594)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ePWYS-0006O0-GM
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 11:40:16 -0500
Received: by mail-oi0-x235.google.com with SMTP id x20so4285022oix.12
	for <qemu-devel@nongnu.org>; Thu, 14 Dec 2017 08:40:16 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171214124817.2567-1-dgilbert@redhat.com>
References: <20171214124817.2567-1-dgilbert@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 14 Dec 2017 16:39:55 +0000
Message-ID: <CAFEAcA_Ry6tpH-e+Nwz7vx6supfrwfrR3=EQTgx0W2R2+g45hA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/2] hmp queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 14 December 2017 at 12:48, Dr. David Alan Gilbert (git)
<dgilbert@redhat.com> wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> The following changes since commit 0a0dc59d27527b78a195c2d838d28b7b49e5a639:
>
>   Update version for v2.11.0 release (2017-12-13 14:31:09 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/dagrh/qemu.git tags/pull-hmp-20171214
>
> for you to fetch changes up to 0eaf3b824745cacebfc321aef6787528d33d58fe:
>
>   tests: test-hmp: print command execution result (2017-12-14 11:09:42 +0000)
>
> ----------------------------------------------------------------
> HMP pull 2017-12-14
>
> ----------------------------------------------------------------
> Thomas Huth (1):
>       hmp-commands: Remove the deprecated usb_add and usb_del
>
> Vadim Galitsyn (1):
>       tests: test-hmp: print command execution result
>
Applied, thanks.

-- PMM

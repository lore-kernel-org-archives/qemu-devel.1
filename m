Received: from eggs.gnu.org ([2001:4830:134:3::10]:39570)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gKAh9-00063U-IN
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 18:23:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gKASs-0000yQ-8g
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 18:08:56 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:45390)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gKASs-0000v9-0X
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 18:08:54 -0500
Received: by mail-ot1-x344.google.com with SMTP id g10so13097772otl.12
	for <qemu-devel@nongnu.org>; Tue, 06 Nov 2018 15:08:53 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1541540283-45699-1-git-send-email-pbonzini@redhat.com>
References: <1541540283-45699-1-git-send-email-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 6 Nov 2018 23:08:32 +0000
Message-ID: <CAFEAcA9HrVVopiT0Crw=BkV+_4_cArt_k5SkMOG5phZh0tFCxQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/17] Misc patches for QEMU 3.1 hard freeze
 (?)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 6 November 2018 at 21:37, Paolo Bonzini <pbonzini@redhat.com> wrote:
> The following changes since commit fc3d1bad1edf08871275cf469a64e12dae4eba96:
>
>   oslib-posix: Use MAP_STACK in qemu_alloc_stack() on OpenBSD (2018-11-06 10:52:23 +0000)
>
> are available in the git repository at:
>
>   git://github.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to a458774ad711bceabefbf01e8f0b91d86ec72e0c:
>
>   util/qemu-thread-posix: Fix qemu_thread_atexit* for OSX (2018-11-06 21:35:06 +0100)
>
> Vitaly's patch is a bit late; unfortunately I couldn't resend the pull
> request yesterday because of a long weekend.  On the other hand this
> meant I could include three more bugfix series, and also fix some nits
> pointed out by Laszlo who just came back from his own vacation.

Missed rc0 by four hours or so, but never mind -- it'll go into rc1.

thanks
-- PMM
